pragma solidity ^0.4.19;

contract Song {

    struct SongToken {
        string name;
        string magnetLink;
        address artist;
        uint64 tokenExpire;
    }

    SongToken public token;

    SongToken[] public tokens;

    function createToken() public {
        token = SongToken("Song1", "MagnetLink", 0x01, uint64(now));
        tokens.push(SongToken("Song2", "MagnetLink2", 0x02, uint64(now)));
    }
}