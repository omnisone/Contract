pragma solidity ^0.4.19;

import "zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";

contract Song is ERC721Token ("Song", "SNG"), Ownable {
    using SafeMath for uint256;
    using SafeMath for uint64;

    uint coinCost = 1;
    bool pause = false;
    struct SongTokenData {
        string name;
        string magnetLink;
        address artist;
        uint256 tokenCreate;
        uint256 tokenExpire;
    }

    mapping(uint256 => SongTokenData) public songData;

    function createToken(string name, string link, address artist) private {
        require(!pause);
        uint256 _tokenId = totalSupply().add(1);
        _mint(msg.sender, _tokenId);
        addSongData(name, link, artist, _tokenId);
    }

    function addSongData(string name, string link, address artist, uint256 _tokenId) private {
        require(!pause);
        songData[_tokenId] = SongTokenData(name, link, artist, now, now);
    }

    function payMinting() external payable{
        require(!pause);
        require(msg.value == coinCost);
        createToken("Song1.1", "URL", owner);
    }

    function extendLease(uint _tokenId) external payable {
        require(!pause);
        songData[_tokenId].tokenExpire = songData[_tokenId].tokenExpire.add(msg.value * 36000000);
    }

    function withdraw() onlyOwner external{
        require(address(this).balance > 0);
        owner.transfer(address(this).balance);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    function pauseContract() onlyOwner public {
        pause = !pause;
    }

    function getPause() public view returns (bool) {
        return pause;
    }
}