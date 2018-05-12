pragma solidity ^0.4.19;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Song is ERC721Token ("Song", "SNG"), Ownable {
    using SafeMath for uint256;
    using SafeMath for uint64;

    uint coinCost = 1;

    struct SongTokenData {
        string name;
        string magnetLink;
        address artist;
        uint256 tokenCreate;
        uint256 tokenExpire;
    }

    mapping(uint256 => SongTokenData) public songData;

    function createToken(string name, string link, address artist) private {
        uint256 _tokenId = totalSupply().add(1);
        _mint(msg.sender, _tokenId);
        addSongData(name, link, artist, _tokenId);
    }

    function addSongData(string name, string link, address artist, uint256 _tokenId) private {
        songData[_tokenId] = SongTokenData(name, link, artist, now, now);
    }

    function payMinting() external payable{
        require(msg.value == coinCost);
        createToken("Song1.1", "URL", 0x212);
    }

    function extendLease(uint _tokenId) external payable {
        require(msg.value > 0);
        songData[_tokenId].tokenExpire = songData[_tokenId].tokenExpire.add(msg.value * 36000000);
    }
}