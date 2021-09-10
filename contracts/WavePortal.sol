// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;

  mapping(address => uint) wavesByAddress;

  constructor() {
    console.log("I'm a smart contract!");
  }

  function wave() public {
    totalWaves += 1;
    wavesByAddress[msg.sender] += 1;
    console.log("%s has waved waved %d times", msg.sender, wavesByAddress[msg.sender]);
  }

  function getTotalWaves() view public returns (uint) {
    console.log("we have %d waves", totalWaves);
    return totalWaves;
    
  }
}
