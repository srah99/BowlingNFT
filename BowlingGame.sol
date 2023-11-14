// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract BowlingGame is VRFConsumerBase {
    uint256 public randomResult;
    address public owner;
    uint256 public gameId;

    event Roll(uint256 indexed gameId, address indexed player, uint256 pins);

    constructor(address vrfCoordinator, address linkToken, bytes32 keyHash)
        VRFConsumerBase(vrfCoordinator, linkToken)
    {
        owner = msg.sender;
        // Set key hash for randomness
        keyHash = keyHash;
    }

    function roll(uint256 pins) external {
        require(msg.sender == owner, "Only owner can roll");
        require(pins <= 10, "Invalid number of pins");

        // Generate random number for the number of knocked down pins
        bytes32 requestId = requestRandomness(keyHash, 1);
        gameId++;
        emit Roll(gameId, msg.sender, pins);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomness)
        internal
        override
    {
        randomResult = randomness;
    }
}
