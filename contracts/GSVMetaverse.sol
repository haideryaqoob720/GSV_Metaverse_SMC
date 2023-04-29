// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

// Openzeppelin Imports
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// Local Imports
import "./GSVToken.sol";

contract GSVMetaverse is OwnableUpgradeable {
    GSVToken public token;
    string public name;
    address adminWalletAddress;

    // pools
    uint public poolTotalSupply;

    uint public poolOfEcosystem;
    uint public poolOfCompanyReserve;
    uint public poolOfTeam;
    uint public poolOfBDAndPartnership;
    uint public poolOfMarketing;
    uint public poolOfLiquidityAndListing;
    uint public poolOfSeedSale;
    uint public poolOfPrivateSale;
    uint public poolOfPublicSale;

    address public firstPoolAdmin;
    address public secPoolAdmin;
    address public trdPoolAdmin;

    mapping(address => uint256) public stakes;

    address[] public stakers;
    Stakeholder[] public stakeholders;

    event Staked(
        address indexed user,
        uint256 amount,
        uint256 index,
        uint256 timestamp
    );

    struct Stake {
        uint256 amount;
        uint256 since;
        uint32 timeStaked;
        address user;
        bool claimable;
        address poolAdminAddr;
        string poolName;
    }

    struct S_liquidity {
        uint256 amount;
        uint256 sinse;
    }

    struct Stakeholder {
        address user;
        Stake[] address_stakes;
    }

    // constructor(IERC20Upgradeable _token, string memory _name) public {
    function storeConstructor(
        GSVToken _token,
        string memory _name,
        uint _tokenTotalSupply
    ) public {
        stakeholders.push();
        token = _token;
        name = _name;
        poolTotalSupply = _tokenTotalSupply;
        adminWalletAddress = msg.sender;
        poolOfEcosystem = (_tokenTotalSupply * 40) / 100;
        poolOfCompanyReserve = (_tokenTotalSupply * 10) / 100;
        poolOfTeam = (_tokenTotalSupply * 5) / 100;
        poolOfBDAndPartnership = (_tokenTotalSupply * 5) / 100;
        poolOfMarketing = (_tokenTotalSupply * 5) / 100;
        poolOfLiquidityAndListing = (_tokenTotalSupply * 15) / 100;
        poolOfSeedSale = (_tokenTotalSupply * 10) / 100;
        poolOfPrivateSale = (_tokenTotalSupply * 5) / 100;
        poolOfPublicSale = (_tokenTotalSupply * 5) / 100;

        // Initializing the Pool Owners
        firstPoolAdmin = 0xDF99f983073112a7e4D582cBf77c690d9ea7F39a;
        secPoolAdmin = 0x3997d3AccEBad60EbAe81B2191F81f9055b3B420;
        trdPoolAdmin = 0xD775Ee0a9Dd3298d4ecD5993BE56eA9Ab31909e6;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function userHistoryOfFunds() external view returns (Stakeholder memory) {
        uint256 index = stakes[msg.sender];
        return stakeholders[index];
    }

    function exchangeHistoryOfFunds()
        external
        view
        returns (Stakeholder[] memory)
    {
        return stakeholders;
    }

    function _checkAmountAndPoolName(
        uint8 _whichPool
    ) internal view returns (uint256, string memory) {
        uint liqOfwhichPool;
        string memory nameOfPool;

        if (_whichPool == 1) {
            liqOfwhichPool = poolOfEcosystem;
            nameOfPool = "Ecosystem";
        } else if (_whichPool == 2) {
            liqOfwhichPool = poolOfCompanyReserve;
            nameOfPool = "CompanyReserve";
        } else if (_whichPool == 3) {
            liqOfwhichPool = poolOfTeam;
            nameOfPool = "Team";
        } else if (_whichPool == 4) {
            liqOfwhichPool = poolOfBDAndPartnership;
            nameOfPool = "BDAndPartnership";
        } else if (_whichPool == 5) {
            liqOfwhichPool = poolOfMarketing;
            nameOfPool = "Marketing";
        } else if (_whichPool == 6) {
            liqOfwhichPool = poolOfLiquidityAndListing;
            nameOfPool = "LiquidityAndListing";
        } else if (_whichPool == 7) {
            liqOfwhichPool = poolOfSeedSale;
            nameOfPool = "SeedSale";
        } else if (_whichPool == 8) {
            liqOfwhichPool = poolOfPrivateSale;
            nameOfPool = "PrivateSale";
        } else if (_whichPool == 9) {
            liqOfwhichPool = poolOfPublicSale;
            nameOfPool = "PublicSale";
        } else {
            liqOfwhichPool = 0;
            nameOfPool = "NoPool";
        }
        return (liqOfwhichPool, nameOfPool);
    }

    function _handlingPoolAmount(
        uint8 _whichPool,
        uint liqOfwhichPool
    ) internal {
        if (_whichPool == 1) {
            poolOfEcosystem = liqOfwhichPool;
        } else if (_whichPool == 2) {
            poolOfCompanyReserve = liqOfwhichPool;
        } else if (_whichPool == 3) {
            poolOfTeam = liqOfwhichPool;
        } else if (_whichPool == 4) {
            poolOfBDAndPartnership = liqOfwhichPool;
        } else if (_whichPool == 5) {
            poolOfMarketing = liqOfwhichPool;
        } else if (_whichPool == 6) {
            poolOfLiquidityAndListing = liqOfwhichPool;
        } else if (_whichPool == 7) {
            poolOfSeedSale = liqOfwhichPool;
        } else if (_whichPool == 8) {
            poolOfPrivateSale = liqOfwhichPool;
        } else if (_whichPool == 9) {
            poolOfPublicSale = liqOfwhichPool;
        }
    }

    function _addFundholder(address staker) internal returns (uint256) {
        stakeholders.push();
        uint256 userIndex = stakeholders.length - 1;
        stakeholders[userIndex].user = staker;
        stakes[staker] = userIndex;
        return userIndex;
    }

    function transferFunds(
        uint256 _amount,
        address _recipientAddress,
        uint32 _timeStaked,
        uint8 _whichPool
    ) public {
        // Check that the requested amount of tokens to sell is more than 0
        require(_amount > 0, "Cannot Transfer nothing");

        // address AdminAddrOfwhichPool;
        uint liqOfwhichPool;
        string memory nameOfPool;

        (liqOfwhichPool, nameOfPool) = _checkAmountAndPoolName(_whichPool);

        bool isAdminCalling;

        if (msg.sender == firstPoolAdmin) {
            isAdminCalling = true;
        } else if (msg.sender == secPoolAdmin) {
            isAdminCalling = true;
        } else if (msg.sender == trdPoolAdmin) {
            isAdminCalling = true;
        } else {
            isAdminCalling = false;
        }

        // Check that the msg.sender is the owner of that pool
        require(
            isAdminCalling == true,
            "You are not the admin of selected pool"
        );

        // Check that the user's token balance is enough to do the swap
        uint256 adminTokenBalance = liqOfwhichPool;
        require(
            adminTokenBalance >= _amount,
            "Your balance is lower than the amount of tokens you want to stake"
        );

        uint256 index = stakes[msg.sender];
        if (index == 0) {
            index = _addFundholder(msg.sender);
        }
        liqOfwhichPool -= _amount;

        // Deducting AMount from from pool
        _handlingPoolAmount(_whichPool, liqOfwhichPool);

        bool sent = token.transfer(_recipientAddress, _amount);
        require(sent, "Failed to transfer tokens");

        stakeholders[index].address_stakes.push(
            Stake(
                _amount,
                block.timestamp,
                _timeStaked,
                _recipientAddress,
                true,
                msg.sender,
                nameOfPool
            )
        );
        emit Staked(msg.sender, _amount, index, block.timestamp);
    }

    function addLiquidyFromPoolToPool(
        uint256 _amount,
        uint8 _fromWhichPool,
        uint8 _toWhichPool
    ) public {
        // Check that the requested amount of tokens to sell is more than 0
        require(_amount > 0, "Cannot Transfer nothing");

        uint liqOfwhichPoolFrom;
        string memory nameOfPoolFrom;
        (liqOfwhichPoolFrom, nameOfPoolFrom) = _checkAmountAndPoolName(
            _fromWhichPool
        );

        uint liqOfwhichPoolTo;
        string memory nameOfPoolTo;
        (liqOfwhichPoolTo, nameOfPoolTo) = _checkAmountAndPoolName(
            _toWhichPool
        );

        bool isAdminCalling;

        if (
            msg.sender == firstPoolAdmin ||
            msg.sender == secPoolAdmin ||
            msg.sender == trdPoolAdmin
        ) {
            isAdminCalling = true;
        } else {
            isAdminCalling = false;
        }

        // Check that the msg.sender is the owner of that pool
        require(
            isAdminCalling == true,
            "You are not the admin of selected pool"
        );

        // Check that the user's token balance is enough to do the swap
        require(
            liqOfwhichPoolFrom >= _amount,
            "Your balance is lower than the amount of tokens you want to stake"
        );

        //          data saving ************************************************
        // uint256 index = stakes[msg.sender];
        // if (index == 0) {
        //     index = _addFundholder(msg.sender);
        // }
        //          data saving ************************************************
        liqOfwhichPoolFrom -= _amount;
        liqOfwhichPoolTo += _amount;

        // Deducting AMount from from pool
        _handlingPoolAmount(_fromWhichPool, liqOfwhichPoolFrom);
        // Deducting AMount to to pool
        _handlingPoolAmount(_toWhichPool, liqOfwhichPoolTo);

        //          data saving ************************************************
        // stakeholders[index].address_stakes.push(
        //     Stake(
        //         _amount,
        //         block.timestamp,
        //         _timeStaked,
        //         _recipientAddress,
        //         true,
        //         msg.sender,
        //         nameOfPoolFrom
        //     )
        // );
        // emit Staked(msg.sender, _amount, index, block.timestamp);
        //          data saving ************************************************
    }

    // function changePoolAdmin(
    //     address _newOwnerAddress,
    //     uint _whichOwnerToChange
    // ) public {
    //     bool isAdminCalling;

    //     if (
    //         msg.sender == firstPoolAdmin ||
    //         msg.sender == secPoolAdmin ||
    //         msg.sender == trdPoolAdmin
    //     ) {
    //         isAdminCalling = true;
    //     } else {
    //         isAdminCalling = false;
    //     }

    //     // Check that the msg.sender is the owner of that pool
    //     require(
    //         isAdminCalling == true,
    //         "You are not the admin of selected pool"
    //     );

    //     if (_whichOwnerToChange == 1) {
    //         firstPoolAdmin = _newOwnerAddress;
    //     } else if (_whichOwnerToChange == 2) {
    //         secPoolAdmin = _newOwnerAddress;
    //     } else if (_whichOwnerToChange == 3) {
    //         trdPoolAdmin = _newOwnerAddress;
    //     } else {
    //         require(_whichOwnerToChange != 1, "This is not any pool");
    //     }
    // }
}
