contract Deposit {

    address public owner;
    bool paused = false;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier whenPaused() {
        require(paused);
        _;
    }

    modifier whenNotPaused() {
        require(! paused);
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function pause() public onlyOwner whenNotPaused {
        paused = true;
    }

    function unpause() public onlyOwner whenPaused {
        paused = false;
    }

    function deposit() public payable whenNotPaused {
        //Ether deposit logic here
    }

    function emergencyWithdraw() public onlyOwner whenPaused {
        owner.transfer(address(this).balance);
    }
}