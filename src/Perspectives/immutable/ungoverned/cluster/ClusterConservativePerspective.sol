// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity ^0.8.24;

import {BasePerspective} from "../../../BasePerspective.sol";
import {ClusterConservativeWithRecognizedCollateralsPerspective} from
    "./ClusterConservativeWithRecognizedCollateralsPerspective.sol";

contract ClusterConservativePerspective is ClusterConservativeWithRecognizedCollateralsPerspective {
    constructor(
        address vaultFactory_,
        address routerFactory_,
        address adapterRegistry_,
        address irmFactory_,
        address escrowSingletonPerspective_
    )
        ClusterConservativeWithRecognizedCollateralsPerspective(
            vaultFactory_,
            routerFactory_,
            adapterRegistry_,
            irmFactory_,
            new address[](0)
        )
    {
        require(
            keccak256(bytes(BasePerspective(escrowSingletonPerspective_).name()))
                == keccak256("Immutable.Ungoverned.EscrowSingletonPerspective"),
            "Invalid escrow perspective"
        );

        recognizedCollateralPerspectives.push(escrowSingletonPerspective_);
        recognizedCollateralPerspectives.push(address(0));
    }

    function name() public pure override returns (string memory) {
        return "Immutable.Ungoverned.ClusterConservativePerspective";
    }
}