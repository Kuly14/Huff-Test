// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import {HuffConfig} from "foundry-huff/HuffConfig.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";
import "../src/AddTwo.sol";

interface Add {
    function addNums() external returns (uint);
}

interface Auth {
    function callContract() external;
}

contract OwnableTest is Test {
    Auth public auth;
    AddTwo public add;
    address constant OWNER = address(0x420);

    event ShowEvent(uint indexed x);

    function setUp() public {
        HuffConfig config = HuffDeployer.config().with_args(abi.encode(OWNER));
        auth = Auth(config.deploy("Auth"));
        add = new AddTwo();
    }

    function testThing() public {
        address x = address(add);
        address y = address(auth);
        uint z;

        assembly {
            mstore(
                0x00,
                0x0f24df3a00000000000000000000000000000000000000000000000000000000
            )

            mstore(0x04, x)

            let success := call(gas(), x, 0, 0x00, 36, 0, 0)

            let storeIt := 0x222222222222222

            mstore(0xd0, storeIt)

            if iszero(success) {
                revert(0xd0, 32)
            }

            let size := returndatasize()

            returndatacopy(0x80, 0, size)

            z := mload(0x80)
        }
        emit ShowEvent(z);
    }
}
