const Kindly = artifacts.require("Kindly");

module.exports = function (deployer) {
    let charityAddress = "0x9D75962c692355c9377295aA2590383F5852E702";// "0x1c01636C8250718447eE2f60611f2B895c9998Cb"; // "0x1c01636C8250718447eE2f60611f2B895c9998Cb";
    let devAddress = "0x939aF5AD7fd35c63A86c14e70d89ea541383d26D";//"0xd03ea8624C8C5987235048901fB614fDcA89b117"; // "0xd03ea8624C8C5987235048901fB614fDcA89b117";
    let liquidityWalletAddress = "0x624014B2c9e148DD8C1B5e00385cF86E77EDAE0a";//"0xdC9bF2bC61F4E3B085Eb7d9a5a9E39157891e1d8"; // "0xdC9bF2bC61F4E3B085Eb7d9a5a9E39157891e1d8";
    deployer.deploy(Kindly, charityAddress, devAddress, liquidityWalletAddress);
};