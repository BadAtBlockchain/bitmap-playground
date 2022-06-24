// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Contract {
    uint256 constant public MAX_LEVELS = 256 / 8; // uint8 for each level stored in a single uint256?!
    uint8 constant internal BITS_PER_LEVEL = 8;
    uint256 constant internal LEVEL_MASK = 0xFF;

    // LEVEL "keys"
    uint256 constant internal LEVEL_A = 0;
    uint256 constant internal LEVEL_B = 1;
    uint256 constant internal LEVEL_C = 2;

    mapping(uint256 => uint256) public levels;

    constructor() {}

    function randomise(uint256 tokenId) public {
        uint256 _a = random(1, 10);
        uint256 _b = random(1, 10);
        uint256 _c = random(1, 10);

        _setValue(tokenId, 0, _a);
        _setValue(tokenId, 1, _b);
        _setValue(tokenId, 2, _c);
    }

    function increaseLevelA(uint256 tokenId) public {
        // increment the target level?!
        uint256 _current = _getValue(tokenId, LEVEL_A);
        _current += 1;
        _setValue(tokenId, LEVEL_A, _current);
    }

    function increaseLevelB(uint256 tokenId) public {

    }

    function increaseLevelC(uint256 tokenId) public {

    }

    function getLevelA(uint256 tokenId) public view returns (uint256) {
        return _getValue(tokenId, LEVEL_A);
    }

    function getLevelB(uint256 tokenId) public view returns (uint256) {
        return _getValue(tokenId, LEVEL_B);
    }

    function getLevelC(uint256 tokenId) public view returns (uint256) {
        return _getValue(tokenId, LEVEL_C);
    }

    function _getValue(uint256 tokenId, uint256 skill) internal view returns (uint256) {
        uint256 _levels = levels[tokenId];
        uint256 _index = skill % MAX_LEVELS;
        
        uint256 _level = (_levels >> (BITS_PER_LEVEL * _index)) & LEVEL_MASK;
        return _level;
    }

    function _setValue(uint256 tokenId, uint256 skill, uint256 level) internal {
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
