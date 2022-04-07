pragma solidity ^0.4.18;

contract SimpleToken {
    address owner;

    string public constant name = "Simple Token";
    string public constant symbol = "ST";
    uint8 public constant decimals = 0;

    mapping (address => uint) public balanceOf;

    event Transfer(address from, address to, uint value);

    function transfer(address _to, uint _value) public {
        address _from = msg.sender;
        require(_to != address(0));
        require(balanceOf[_from] >= _value);
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
    }

    function SimpleToken() public {
        balanceOf[msg.sender] = 1000000000000000;
    }

    function killcontract() public {
        if(owner == msg.sender)
            selfdestruct(owner);
    }
}