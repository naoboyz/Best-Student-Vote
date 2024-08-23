// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BestStudentVoting {
    // Structure to store student details
    struct Student {
        string name;
        uint256 votes;
    }

    // Array to store all nominated students
    Student[] public students;
    // Mapping to keep track of whether an address has voted
    mapping(address => bool) public hasVoted;
    // Mapping to keep track of whether a student has been nominated
    mapping(string => bool) public isNominated;

    // Event to log nominations
    event Nominated(string studentName);
    // Event to log votes
    event Voted(address indexed voter, string studentName);

    // Function to nominate a student
    function nominate(string memory studentName) public {
        require(!isNominated[studentName], "Student already nominated");
        students.push(Student(studentName, 0));
        isNominated[studentName] = true;
        emit Nominated(studentName);
    }

    // Function to vote for a student
    function vote(string memory studentName) public {
        require(!hasVoted[msg.sender], "You have already voted");
        require(isNominated[studentName], "Student not nominated");

        for (uint256 i = 0; i < students.length; i++) {
            if (keccak256(bytes(students[i].name)) == keccak256(bytes(studentName))) {
                students[i].votes++;
            }
        }
    }
}
          
