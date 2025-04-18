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

// Implementation : 0xFeA304922a1bE190f1EBFBf25C7153F716eE26d1
// Proxy : 0x015F5A00B3a77145603F90DEd56fDb4F00480592