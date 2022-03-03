contract DividendContract is Ownable {
    address[] public investors;

    function registerInvestor(address _investor) public onlyOwner {
        require(_investor != address(0));
        investors.push(_investor);
    }

    function distributeDividend() public onlyOwner {
        for (uint256 i = 0; i < investors.length; i++) {
            uint256 amount = calculateDividend(investors[i]);
            investors[i].transfer(amount); //Push ether to user
        }
    }

    function calculateDividend(address _investor) internal returns (uint256) {
        //Dividend calculation here
    }










    function claimDividend() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0);
        //Ensure to update balance before transfer
        //to avoid reentrancy attack
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
}
