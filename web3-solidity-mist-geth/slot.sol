pragma solidity ^0.4.18;

contract slot {
    address owner;
    uint gameNumber;
    struct game {
        address player;
        bool win;
        uint bettingAmout;
        uint reward;
        uint blockNumber;
    }
    game[] public game;
    event sendResult (address player, bool win, uint amount, uint8 n1, uint8 n2, uint8 n3);

    function slot() payable {
        owner = msg.sender;
    }

    // 배팅을 하는 함수
    function bet() payable {
        if (this.balance < msg.value * 64)
            revert();

        bool win = false;
        uint gameResult = uint(block.blockhash(block.number-1)) % 1000;
        uint n1 = gameResult / 100;
        uint n2 = (gameResult % 100) / 10;
        uint n3 = gameResult % 10;

        uint reward = msg.value;
        if(n1 == n2) { reward = reward * 4; win = true;}
        if(n2 == n3) { reward = reward * 4; win = true;}
        if(n1 == n3) { reward = reward * 4; win = true;}

        if(win)
            msg.sender.transfer(reward);
        else
            reward = 0;

        sendResult(msg.sender, win, reward, n1, n2, n3);
        games.push(game(msg.sender, win, msg.value, gameResult, reward, block.number));
    }

    function killcontract() {
        if(owner == msg.sender)
            selfdestruct(owner);
    }

    function bat() payable { }
}