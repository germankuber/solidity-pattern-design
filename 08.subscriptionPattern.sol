contract Subscription is Ownable {
    using SafeMath for uint256;
    //subscriber address => expiry
    mapping(address => uint256) public subscribed;
    address[] public subscriptions;
    uint256 subscriptionFeePerDay = 1 ether;

    modifier whenExpired() {
        require(isSubscriptionExpired(msg.sender));
        _;
    }

    modifier whenNotExpired() {
        require(!isSubscriptionExpired(msg.sender));
        _;
    }

    constructor(uint256 _subscriptionFeePerDay) public {
        subscriptionFeePerDay = _subscriptionFeePerDay;
    }

    function isSubscriptionExpired(address _addr) public view returns (bool) {
        uint256 expireTime = subscribed[_addr];
        return expireTime == 0 || now > expireTime;
    }

    function subscribe(uint256 _days) public payable whenExpired {
        require(_days > 0);
        require(msg.value == subscriptionFeePerDay.mul(_days));
        subscribed[msg.sender] = now.add((_days.mul(1 days)));
        subscriptions.push(msg.sender);
    }

    function withdraw() public onlyOwner {
        owner().transfer(address(this).balance);
    }

    function useService() public whenNotExpired {
        //User allowed to use service
    }
}
