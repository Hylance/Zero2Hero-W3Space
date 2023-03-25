// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract W3SpaceEvent is ERC721A, Ownable {

    struct Event {
        string eventName;
        address creator;
        uint id;
    }
    string public baseURI = "";
    mapping(address => Event[]) public events;
    mapping(address => bool) public collected;

    constructor(
        string memory _tokenName,
        string memory _tokenSymbol
    ) ERC721A(_tokenName, _tokenSymbol) {}

    function createEvent(string memory eventName) external payable {
        Event[] storage myEvents = events[msg.sender];
        myEvents.push(Event({
            eventName: eventName,
            creator: msg.sender,
            id: totalSupply()
        }));
    }

    function collect() external {
        _safeMint(msg.sender, 1);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function poaCollected(address user) public view returns (uint256) {
        return _numberMinted(user);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return _baseURI();
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
