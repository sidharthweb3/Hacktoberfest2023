// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface IStakingPool {
    function getTotalStakeByProvider(address) external view returns (uint256);

    function withdrawReward(uint256 amount, address _staker) external;

    function deposit(uint, address) external;

    function transferFromContract(
        uint amt,
        address _add,
        bool _reward
    ) external;
}

contract DeviceShare {
    uint256 public FIXED_STAKE;
    uint256 private constant SECONDS_IN_YEAR = 31536000; // Number of seconds in a year (365 days)
    address public owner;
    IStakingPool public poolContract;

    IERC20 private token;

    constructor(
        address tokenAddress,
        uint256 _FIXED_STAKE,
        address _poolContract
    ) {
        token = IERC20(tokenAddress);
        poolContract = IStakingPool(_poolContract);
        owner = msg.sender;
        FIXED_STAKE = _FIXED_STAKE;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
    struct Provide {
        string[] name;
        uint256[] totalGPU;
        uint256[] GPURam;
        string[] uri;
        uint256[] hrs;
        uint256[] tokenRate;
        uint256[] devid;
        bool[] engage;
        address payable recipient;
        uint256[] reqDetailsPerDevice;
    }

    struct DeviceDetails {
        string name;
        uint256 totalGPU;
        uint GPURam;
        string uri;
        uint256 hrs;
        uint256 tokenRate;
        uint256 devid;
        bool engage;
        address payable recipient;
        uint256[] requestIDs;
        uint256[] requestHRs;
        uint256 finalRequestID;
        uint256 timestamp;
        // uint256 stakeid;
    }
    mapping(address => Provide) public providers;
    mapping(uint256 => DeviceDetails) public deviceDetails;
    mapping(address => uint256) public rewardEarnedByProvider;
    uint256 public deviceID;
}}
