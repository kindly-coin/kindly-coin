// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.3;

import "./Context.sol";

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;
    address payable private _charityWalletAddress;
    address payable private _devWalletAddress;
    address payable private _liquidityWalletAddress;
    address private _burnAddress = address(0x0000000000000000000000000000000000000001);
    address private _lockedLiquidity;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event CharityAddressChanged(address oldAddress, address newAddress);
    event DevAddressChanged(address oldAddress, address newAddress);
    event LiquidityWalletAddressChanged(address oldAddress, address newAddress);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }
    
    function lockedLiquidity() public view returns (address) {
        return _lockedLiquidity;
    }
    
    function charity() public view returns (address payable)
    {
        return _charityWalletAddress;
    }

    function dev() public view returns (address payable)
    {
        return _devWalletAddress;
    }

    function liquidityWallet() public view returns (address payable)
    {
        return _liquidityWalletAddress;
    }
    
    function burn() public view returns (address)
    {
        return _burnAddress;
    }
    
    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    
    modifier onlyCharity() {
        require(_charityWalletAddress == _msgSender(), "Caller is not the charity address");
        _;
    }

    modifier onlyDev() {
        require(_devWalletAddress == _msgSender(), "Caller is not the dev address");
        _;
    }

     /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function excludeFromReward(address account) public virtual onlyOwner() {
    }
    
    function setCharityAddress(address payable charityAddress) public virtual onlyOwner
    {
        //require(_charity == address(0), "Charity address cannot be changed once set");
        emit CharityAddressChanged(_charityWalletAddress, charityAddress);
        _charityWalletAddress = charityAddress;
        excludeFromReward(charityAddress);
    }

    function setDevAddress(address payable devAddress) public virtual onlyOwner
    {
        //require(_dev == address(0), "Dev address cannot be changed once set");
        emit DevAddressChanged(_devWalletAddress, devAddress);
        _devWalletAddress = devAddress;
        excludeFromReward(devAddress);
    }

    function setLiquidityWalletAddress(address payable liquidityWalletAddress) public virtual onlyOwner
    {
        //require(_dev == address(0), "Liquidity address cannot be changed once set");
        emit LiquidityWalletAddressChanged(_liquidityWalletAddress, liquidityWalletAddress);
        _liquidityWalletAddress = liquidityWalletAddress;
        excludeFromReward(liquidityWalletAddress);
    }
    
    function setLockedLiquidityAddress(address liquidityAddress) public virtual onlyOwner
    {
        require(_lockedLiquidity == address(0), "Locked liquidity address cannot be changed once set");
        _lockedLiquidity = liquidityAddress;
    }

}