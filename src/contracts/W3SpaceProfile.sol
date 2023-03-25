// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract W3SpaceProfile is ERC721A, Ownable {

    struct User {
        string username;
        address wallet;
    }
    string public baseURI = "";
    uint256 public publicPrice = 0 ether;
    mapping(address => User[]) public followed;      // Alice => people follows Alice
    mapping(address => User[]) public following;     // Alice => people Alice is following
    mapping(address => User) public users;

    constructor(
        string memory _tokenName,
        string memory _tokenSymbol
    ) ERC721A(_tokenName, _tokenSymbol) {}

    function createProfile(string memory username) external payable {
        require(msg.value >= publicPrice, 'Not enough eth');
        User storage sender = users[msg.sender];
        sender.wallet = msg.sender;
        sender.username = username;
        _safeMint(msg.sender, 1);
    }

    function getProfile(address people) public view returns(string memory){
        User memory profile = users[people];
        return profile.username;
    }

    function isFollowed(address other, address me) public view returns (bool) {
        User[] memory fans = followed[other];
        for (uint i = 0; i < fans.length; i++) {
            if(fans[i].wallet == me) {
                return true;
            }
        }
        return false;
    }

    function follow(address other) external {
        User[] storage fans = followed[other];
        User memory me = users[msg.sender];
        fans.push(me);
        User[] storage friends = following[msg.sender];
        User memory target = users[other];
        friends.push(target);
    }

    function getFollowings(address people) public view returns (User[] memory) {
        User[] memory friends = following[people];
        return friends;
    }

    function getFollowers(address people) public view returns (User[] memory){
        User[] memory fans = followed[people];
        return fans;
    }

    function unfollow(address other) external {
        User[] storage fans = followed[other];
        for (uint i = 0; i < fans.length; i++) {
            if (fans[i].wallet == msg.sender) {
                remove(i, fans);
                break;
            }
        }
        User[] storage friends = following[msg.sender];
        for (uint j = 0; j < friends.length; j++) {
            if (friends[j].wallet == other) {
                remove(j, friends);
                break;
            }
        }
    }

    function remove(uint index, User[] storage array) internal {
        array[index] = array[array.length - 1];
        array.pop();
    }


    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function profileCreated(address owner) public view returns (uint256) {
        return _numberMinted(owner);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return _baseURI();
    }

    function setPublicPrice(uint256 _newPublicPrice) external onlyOwner {
        publicPrice = _newPublicPrice;
    }

    function setBaseURI(string memory _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    receive() external payable {

    }

    function withdrawBalance() external onlyOwner {
        (bool success,) = msg.sender.call{value : address(this).balance}("");
        require(success, "WITHDRAW FAILED!");
    }

}
