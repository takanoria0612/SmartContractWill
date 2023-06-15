pragma solidity ^0.8.0;


contract Will {
    address owner;
    uint    fortune;
    bool    deceased;

    constructor() payable  {
        owner = msg.sender; //msg sender represents address that is being called
        fortune = msg.value; //msg value tell sus how much ether is being sent
        deceased  = false;
    }

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    //create modifier so thtat we only allocate funds if friends's gramps deceased
        modifier mustBeDeceased {
        require(deceased == true);
        _;
    }

    address payable[] familyWallets;
    
    // map through inheritance
    mapping(address => uint) inheritance;

    // set inheritance for each address
    function setInheritance(address payable wallet, uint amount) public {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    // Pay each family memgber based on their wallet address
    function payout() private mustBeDeceased {
        for(uint i=0; i< familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            // transferring
        }
    }
    // oracle swithc simulation
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }

}
