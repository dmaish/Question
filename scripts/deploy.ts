/* eslint-disable no-unused-vars */
import { ethers } from "hardhat";

async function main() {
  // todo: fill in the deployment code here to deploy ComplexGame, SimpleGame,
  // Please consider upgradability and access control if possible, could change the Corresponding Contract if needed
  const Randomizer = await ethers.getContractFactory("Randomizer");
  console.log("Deploying Box...");

  const randomLib = await Randomizer.deploy();

  const GameRunner = await ethers.getContractFactory("GameRunner", {
    libraries: {
      Randomizer: randomLib.address,
    },
  });
  const gameRunner = await GameRunner.deploy();

  await gameRunner.deployed();
  console.log("gameRunner deployed to:", gameRunner.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
