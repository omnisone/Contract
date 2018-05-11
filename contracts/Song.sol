pragma solidity ^0.4.19;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Song is ERC721Token ("Song", "SNG") {
    using SafeMath for uint256;
    using SafeMath for uint64;

    struct SongTokenData {
        string name;
        string magnetLink;
        address artist;
        uint256 tokenCreate;
        uint256 tokenExpire;
    }

    mapping(uint256 => SongTokenData) public songData;

    function getNumberOfTokens() public returns (uint256){
        return balanceOf(msg.sender);
    }

    function createToken(string name, string link, address artist) public {
        uint256 _tokenId = totalSupply().add(1);
        _mint(msg.sender, _tokenId);
        addSongData(name, link, artist, _tokenId);
    }

    function addSongData(string name, string link, address artist, uint256 _tokenId) private{
        songData[_tokenId] = SongTokenData(name, link, artist, now, now);
    }
}