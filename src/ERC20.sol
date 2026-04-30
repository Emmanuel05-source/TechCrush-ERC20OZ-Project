// SPDX-License-Identifier:MIT
pragma solidity 0.8.30;
// IMPORT ERC20 CONTRACT FROM OPEN ZEPPLIN
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract ERC20OZ is ERC20, Ownable {
    // is means inheritance
    string public s_name;
    string private s_symbol;

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) Ownable(msg.sender) {
        // ethereum and the symbol to be ETH
        s_name = _name;
        s_symbol = _symbol;
        _mint(msg.sender, 1000000000e15);
        mint(10000000, 0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65);
        // 10000000wei/ 1e18
        // decimals();
    }

    function mint(uint256 _amount, address meThief) public onlyOwner {
        _mint(meThief, _amount);
    }

    function burn(uint256 amount) public onlyOwner {
        _burn(msg.sender, amount);
    }
    //
    // function decimals() public view override returns (uint8) {
    //     return 6;
    // }
}
