async function main() {
  const [owner, randoPerson] = await ethers.getSigners();
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
  const waveContract = await waveContractFactory.deploy({ value: hre.ethers.utils.parseEther("0.1") });
  await waveContract.deployed();

  console.log("Contract deployed to:", waveContract.address);

  let contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log('Balance', hre.ethers.utils.formatEther(contractBalance));

  let waveCount;
  waveCount = await waveContract.getTotalWaves();

  let waveTxn = await waveContract.wave('A message #1!');
  await waveTxn.wait();

  waveTxn = await waveContract.wave('A newer message #2!');
  await waveTxn.wait();

  contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
  console.log('Balance', hre.ethers.utils.formatEther(contractBalance));

  waveCount = await waveContract.getTotalWaves();
  const waves = await waveContract.getAllWaves();
}

main().then(function() { process.exit(0); }).catch(function(e) { console.error(e); process.exit(1); })
