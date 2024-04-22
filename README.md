
# Solidity Safe Singleton Factory Deployer 
This is a Solidity library for using [Safe Singleton Factory](https://github.com/safe-global/safe-singleton-factory). At the code level, this factory matches [Arachnid's Determinstic Deployment Proxy](https://github.com/Arachnid/deterministic-deployment-proxy). It is different from other deterministic deployment factories in that Safe holds the private key and has NOT shared any presigned transactions. This can help avoid accidental or malicious nonce increments via presigned transactions with invalid gas values for a certain network. 

Safe has currently deployed this factory to 252 chains and it has the same address on 248. 

I made this library so that this factory would be easiser to use with Forge deployment scripts, as there seem to only be existing tools for Hardhat. 