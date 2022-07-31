// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.15;

import "forge-std/Test.sol";
import {HuffConfig} from "foundry-huff/HuffConfig.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

interface Testing {
    function rev() external;
}

contract RevertTest is Test {
    address constant OWNER = address(0x420);
    Testing public tst;

    function setUp() public {
        HuffConfig config = HuffDeployer.config().with_args(abi.encode(OWNER));
        tst = Testing(config.deploy("Test"));
    }

    function testThing() public {
        vm.expectRevert();
        tst.rev();
    }
}
