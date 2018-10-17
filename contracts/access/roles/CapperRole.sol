pragma solidity ^0.4.24;

import "zos-lib/contracts/Initializable.sol";
import "../Roles.sol";


contract CapperRole is Initializable {
  using Roles for Roles.Role;

  event CapperAdded(address indexed account);
  event CapperRemoved(address indexed account);

  Roles.Role private cappers;

  function initialize(address sender) public initializer {
    if (!isCapper(sender)) {
      _addCapper(sender);
    }
  }

  modifier onlyCapper() {
    require(isCapper(msg.sender));
    _;
  }

  function isCapper(address account) public view returns (bool) {
    return cappers.has(account);
  }

  function addCapper(address account) public onlyCapper {
    _addCapper(account);
  }

  function renounceCapper() public {
    _removeCapper(msg.sender);
  }

  function _addCapper(address account) internal {
    cappers.add(account);
    emit CapperAdded(account);
  }

  function _removeCapper(address account) internal {
    cappers.remove(account);
    emit CapperRemoved(account);
  }

  uint256[50] private ______gap;
}
