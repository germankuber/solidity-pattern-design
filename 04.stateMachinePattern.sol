contract LoanContract {
    enum LoanState {
        NONE,
        INITIATED,
        COLLATERAL_RCVD,
        FUNDED,
        REPAYMENT,
        FINISHED
    }

    address public borrower;
    address public lender;
    IERC20 token;
    uint256 collateralAmount;
    uint256 loanAmount;
    LoanState public currentState;

    modifier onlyBorrower() {
        require(msg.sender == borrower);
        _;
    }

    modifier atState(LoanState loanState) {
        require(currentState == loanState);
        _;
    }

    modifier transitionToState(LoanState nextState) {
        _;
        currentState = nextState;
    }

    constructor(
        IERC20 _token,
        uint256 _collateralAmount,
        uint256 _loanAmount
    ) public transitionToState(LoanState.INITIATED) {
        borrower = msg.sender;
        token = _token;
        collateralAmount = _collateralAmount;
        loanAmount = _loanAmount;
    }

    function stateInitialized()
        public
        onlyBorrower
        atState(LoanState.INITIATED)
        transitionToState(LoanState.COLLATERAL_RCVD)
    {
        require(
            IERC20(token).transferFrom(
                borrower,
                address(this),
                collateralAmount
            )
        );
    }

    function putCollateral2()
        public
        onlyBorrower
        atState(LoanState.COLLATERAL_RCVD)
        transitionToState(LoanState.FUNDED)
    {
        require(
            IERC20(token).transferFrom(
                borrower,
                address(this),
                collateralAmount
            )
        );
    }

    function putCollateral2()
        public
        onlyBorrower
        atState(LoanState.FUNDED)
        transitionToState(LoanState.FINISHED)
    {
        require(
            IERC20(token).transferFrom(
                borrower,
                address(this),
                collateralAmount
            )
        );
    }

    function putCollateralFinished()
        public
        onlyBorrower
        atState(LoanState.FINISHED)
    {
        require(
            IERC20(token).transferFrom(
                borrower,
                address(this),
                collateralAmount
            )
        );
    }
}
