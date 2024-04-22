// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mock {
    uint256 public value;

    constructor(uint256 startValue) {
        value = startValue;
    }

    function setValue(uint256 value_) public returns (uint256) {
        return value = value_;
    }
}
