pragma solidity ^0.4.18;

contract slot {
    address owner;
    uint256 gameNumber;
    struct game {
        address player;
        bool win;
        uint256 bettingAmout;
        uint256 reward;
        uint256 blockNumber;
    }
    game[] public games;
    event sendResult (address player, bool win, uint amount, uint256 n1, uint256 n2, uint256 n3);

    function slot() payable public {
        owner = msg.sender;
    }

    // 배팅을 하는 함수
    function bet() payable public {
        if (this.balance < msg.value * 64)
            revert();

        bool win = false;
        uint256 gameResult = uint256(block.blockhash(block.number-1)) % 1000;
        uint256 n1 = gameResult / 100;
        uint256 n2 = (gameResult % 100) / 10;
        uint256 n3 = gameResult % 10;

        uint256 reward = msg.value;
        if(n1 == n2) { reward = reward * 4; win = true;}
        if(n2 == n3) { reward = reward * 4; win = true;}
        if(n1 == n3) { reward = reward * 4; win = true;}

        if(win)
            msg.sender.transfer(reward);
        else
            reward = 0;

        sendResult(msg.sender, win, reward, n1, n2, n3);
        games.push(game(msg.sender, win, msg.value, reward, block.number));
    }

    function killcontract() public {
        if(owner == msg.sender)
            selfdestruct(owner);
    }

    function bat() payable public { }
}