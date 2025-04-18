import {deployments, getNamedAccounts, upgrades} from 'hardhat'

export default async function main() {
    const {Deployer} = await getNamedAccounts(); 
    const RentalNFTContract = await deployments.deploy('RentalNFT', {
        from: Deployer,
        proxy: {
            execute: {
                init: {
                    methodName: 'initialize',
                    args: ['RentalNFT', 'RNFT']
                }
            },
            proxyContract: 'OpenZeppelinTransparentProxy'
        },
        log: true
    })
}

// Implementation : 0x8c4c6ea1A58FCEFa20672f7AAd5f84eb538da95d