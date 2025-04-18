import {deployments, getNamedAccounts, upgrades} from 'hardhat'

export default async function main() {
    const {Deployer} = await getNamedAccounts(); 
    const RentalNFTContract = await deployments.deploy('RentalNFT', {
        from: Deployer,
        proxy: {
            proxyContract: 'OpenZeppelinTransparentProxy'
        },
        log: true
    })
    console.log(RentalNFTContract.address, RentalNFTContract.newlyDeployed);
}

// Implementation : 0x8c4c6ea1A58FCEFa20672f7AAd5f84eb538da95d