// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;
  uint private seed;

  event NewWave(address indexed from, string message, uint timestamp);

  struct Wave {
    address waver;
    string message;
    uint timestamp;
  }

  Wave[] waves;

  mapping(address => uint) public lastWavedAt;

  constructor() payable {
    console.log("I'm a smart contract!");
  }

  function wave(string memory _message) public {
    require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Please wait 15 minutes");

    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves += 1;
    waves.push(Wave(msg.sender, _message, block.timestamp));

    uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
    console.log("Random # generated %s", randomNumber);

    seed = randomNumber;

    if (randomNumber < 50) {
      console.log("%s won!", msg.sender);
      uint prizeAmount = 0.0001 ether;
      require(prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has.");
      (bool success,) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to withdraw money from contract.");
    }

    emit NewWave(msg.sender, _message, block.timestamp);
  }

  function getTotalWaves() view public returns (uint) {
    return totalWaves;
  }

  function getAllWaves() view public returns (Wave[] memory) {
    return waves;
  }
}
