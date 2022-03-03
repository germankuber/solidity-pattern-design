contract AddressList is Ownable {

    mapping(address => bool) internal map;

    function add(address _address) public onlyOwner {
        map[_address] = true;
    }

    function remove(address _address) public onlyOwner {
        map[_address] = false;
    }

    function isExists(address _address) public view returns (bool) {
        return map[_address];
    }
}