// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract KryptoBird is ERC721Connector {
    
string[] public kryptoBirdz;

mapping(string => bool) _kryptoBirdzExists; 

function mint(string memory _kryptoBird) public { //minting function can be public

    require(!_kryptoBirdzExists[_kryptoBird],'Error - kryptoBird already exists');
    // push birz in array to keep track
    // uint _id = kryptoBirdzirdz.push(_kryptoBird) **deprecated .push no longer return the length but a reference to add el
    kryptoBirdz.push(_kryptoBird);
    uint _id = kryptoBirdz.length - 1;

    _mint(msg.sender, _id);

    _kryptoBirdzExists[_kryptoBird] = true;
}
    constructor() ERC721Connector('KryptoBird', 'KBIRDZ') {

    }


}