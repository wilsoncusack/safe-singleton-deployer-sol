// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";

import {SafeSingletonDeployer} from "../src/SafeSingletonDeployer.sol";

import {Mock} from "./Mock.sol";
import {MockReverting} from "./MockReverting.sol";

contract SafeSingletonDeployerTest is Test {
    // cast code 0x914d7Fec6aaC8cd542e72Bca78B30650d45643d7 --rpc-url https://mainnet.base.org
    bytes factoryCode =
        hex"7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe03601600081602082378035828234f58015156039578182fd5b8082525050506014600cf3";

    function setUp() public {
        vm.etch(SafeSingletonDeployer.SAFE_SINGLETON_FACTORY, factoryCode);
    }

    function test_deploy_createsAtExpectedAddress() public {
        address expectedAddress =
            SafeSingletonDeployer.computeAddress(type(Mock).creationCode, abi.encode(1), bytes32("0x1234"));
        assertEq(expectedAddress.code, "");
        address returnAddress = SafeSingletonDeployer.deploy({
            creationCode: type(Mock).creationCode,
            args: abi.encode(1),
            salt: bytes32("0x1234")
        });
        assertEq(returnAddress, expectedAddress);
        assertNotEq(expectedAddress.code, "");
    }

    function test_deploy_createsContractCorrectly() public {
        uint256 startValue = 1;
        address mock = SafeSingletonDeployer.deploy({
            creationCode: type(Mock).creationCode,
            args: abi.encode(1),
            salt: bytes32("0x1234")
        });
        assertEq(startValue, Mock(mock).value());
        uint256 newValue = 2;
        Mock(mock).setValue(newValue);
        assertEq(newValue, Mock(mock).value());
    }

    function test_deploy_reverts() public {
        vm.expectRevert();
        SafeSingletonDeployer.deploy({
            creationCode: type(MockReverting).creationCode,
            args: abi.encode(1),
            salt: bytes32("0x1234")
        });
    }
}
