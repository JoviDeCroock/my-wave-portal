async function main() {
  const [deployer] = await ethers.getSigners();
  console.log('Deploying contracts with the account: ', deployer.address);
  console.log('Account balance: ', (await deployer.getBalance()).toString());
  const Token = await hre.ethers.getContractFactory("WavePortal");
  const token = await Token.deploy({value: ethers.utils.parseEther("0.001")});
  console.log('WavePortal address: ', token.address);
}

main().then(function() { process.exit(0); }).catch(function(e) { console.error(e); process.exit(1); })
