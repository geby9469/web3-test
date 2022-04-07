pragma solidity ^0.4.18;

contract voteContract {
    mapping (address => bool) voters; // 하나의 계정 당 한 번의 투표만 가능
    mapping (string => uint) candidates; // 후보자의 득표수를 저장합니다.
    mapping (uint8 => string) candidateList; // 후보자의 리스트입니다.

    uint8 numberOfCandidates;
    address contractOwner;

    function voteContract() public {
        // 컨트랙트를 생성한 사람을 contractOwner로 저장합니다.
        contractOwner = msg.sender;

    }

    // 후보자를 추가하는 함수입니다.
    function addCandidate(string cand) public {
        bool add = true;
        for (uint8 i = 0; i < numberOfCandidates; i++) {
            // 문자열 비교는 해쉬함수(keccak256)를 통해서 할 수 있습니다.
            if(keccak256(candidateList[i]) == keccak256(cand)) {
                add = false;
                break;
            }
        }
        if(add) {
            candidateList[numberOfCandidates] = cand;
            numberOfCandidates++;
        }
    }

    // 투표를 하는 함수입니다.
    function vote(string cand) public {
        // 하나의 계정은 한번의 투표만 결과에 반영됩니다.
        if(voters[msg.sender]) {

        }
        else {
            voters[msg.sender] = true;
            candidates[cand]++;
        }
    }

    // 이미 투표했는지 확인합니다.
    function alreadyVoted() constant public returns(bool) {
        if(voters[msg.sender])
            return true;
        else
            return false;
    }

    // 후보자의 수를 리턴합니다.
    function getNumOfCandidates() constant public returns(uint8) {
        return numberOfCandidates;
    }

    // 번호에 해당하는 후보의 이름을 리턴합니다.
    function getCandidateString(uint8 number) constant public returns(string) {
        return candidateList[number];
    }

    // 후보의 득표수를 리턴합니다.
    function getScore(string cand) constant public returns(uint) {
        return candidates[cand];
    }

    // 컨트랙트를 삭제합니다.
    function killContract() public {
        if(contractOwner == msg.sender)
            selfdestruct(contractOwner);
    }
    
}