import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import 'hardhat-deploy'
import "@openzeppelin/hardhat-upgrades"
import dotenv from 'dotenv'
dotenv.config()

const realAccount = process.env.DEPLOYER_KEY || "";
const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: 'https://sepolia.infura.io/v3/716bdb39b2f84516b3cedcfb3c2d2c19',
      accounts: [realAccount],
      chainId: 11155111,
    }
  },
  defaultNetwork: 'sepolia',
  namedAccounts: {
    Deployer: {
      default: 0
    }
  }
};

export default config;
