// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";

import {SafeSingletonDeployer} from "../src/SafeSingletonDeployer.sol";
import {Mock} from "../test/Mock.sol";

contract ExampleDeployScript is Script {
  function run() public {
    SafeSingletonDeployer.broadcastDeploy({
      deployer: address(1),
      creationCode: type(Mock).creationCode,
      args: abi.encode(1),
      salt: bytes32("0x1234")
    });
  }
}