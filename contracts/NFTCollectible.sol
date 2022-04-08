pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract NFTCollectible is ERC721Enumerable, Ownable {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    uint256 public constant MAX_SUPPLY = 100;
    uint256 public constant PRICE = 0.01 ether;
    uint256 public constant MAX_PER_MINT = 5;

    string public baseTokenURI;

    constructor(string memory _baseTokenURI) ERC721("NFTCollectible", "NFTC") {
        baseTokenURI = _baseTokenURI;
    }

    function totalSupply() public view override returns (uint256) {
        return _tokenIds.current();
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string memory _baseTokenURI) public {
        baseTokenURI = _baseTokenURI;
    }

    function _mintSingleNFT() private {
        uint256 tokenId = _tokenIds.current();
        _safeMint(msg.sender, tokenId);
        _tokenIds.increment();
    }

    function reserveNFTs() public onlyOwner {
        uint256 totalMinted = _tokenIds.current();

        require(
            totalMinted.add(10) < MAX_SUPPLY,
            "Cannot reserve more than 100 NFTs"
        );

        for (uint256 i = 0; i < 10; i++) {
            _mintSingleNFT();
        }
    }

    function mintNFTs(uint256 _count) public payable {
        uint256 totalMinted = _tokenIds.current();

        require(
            totalMinted.add(_count) < MAX_SUPPLY,
            "Cannot mint more than 100 NFTs"
        );
        require(
            _count > 0 && _count < MAX_PER_MINT,
            "Cannot mint more than 5 NFTs at a time"
        );
        require(
            msg.value >= PRICE.mul(_count),
            "Cannot mint NFTs for less than 0.01 ether"
        );

        for (uint256 i = 0; i < _count; i++) {
            _mintSingleNFT();
        }
    }

    function tokensOfOwner(address _owner)
        external
        view
        returns (uint256[] memory)
    {
        uint256 tokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](tokenCount);

        for (uint256 i = 0; i < tokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function withdraw() public payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ether left to withdraw");

        (bool success, ) = (msg.sender).call{value: balance}("");
        require(success, "Transfer failed.");
    }
}
