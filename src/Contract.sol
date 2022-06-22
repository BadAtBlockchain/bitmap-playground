// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Contract {
    uint256 constant public MAX_LEVELS = 256 / 8; // uint8 for each level stored in a single uint256?!
    uint8 constant internal BITS_PER_LEVEL = 8;
    uint256 constant internal LEVEL_MASK = 0xFF;

    mapping(uint256 => uint256) public levels;

    constructor() {}

    function randomise(uint256 tokenId) public {
        uint256 _a = random(1, 10);
        uint256 _b = random(1, 10);
        uint256 _c = random(1, 10);

        set(tokenId, 0, _a);
        set(tokenId, 1, _b);
        set(tokenId, 2, _c);
    }

    function setLevels(uint256 tokenId) public {
        set(tokenId, 0, 1);
        set(tokenId, 1, 2);
        set(tokenId, 2, 3);
    }

    function get(uint256 tokenId, uint256 skill) public view returns (uint256) {
        uint256 _levels = levels[tokenId];
        uint256 _index = skill % MAX_LEVELS;
        
        uint256 _level = (_levels >> (BITS_PER_LEVEL * _index)) & LEVEL_MASK;

        return _level;
    }

    function set(uint256 tokenId, uint256 skill, uint256 level) public {
        uint256 _levels = levels[tokenId];  
        uint256 _index = skill % MAX_LEVELS;

        _levels &= type(uint256).max ^ (LEVEL_MASK << _index);
        _levels |= level << (_index * BITS_PER_LEVEL);
    
        levels[tokenId] = _levels;
    }

    uint256 private nonce;
    function random(uint256 _min, uint256 _max) internal returns (uint) {
        uint randomnumber = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % _max;
        randomnumber = randomnumber + _min;
        nonce++;
        return randomnumber;
    }
}
