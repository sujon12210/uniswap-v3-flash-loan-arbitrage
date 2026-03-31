const hre = require("hardhat");

async function main() {
  const V3_FACTORY = "0x1F98431c8aD98523631AE4a59f267346ea31F984"; // Mainnet/Polygon/Sepolia

  const FlashArb = await hre.ethers.getContractFactory("FlashArbV3");
  const flashArb = await FlashArb.deploy(V3_FACTORY);

  await flashArb.waitForDeployment();
  console.log("Uniswap V3 Flash Arb deployed to:", await flashArb.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
