// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
mint function use to create NFT

building out the minting the function 

a. nft to point to an address 
b. keep track of the token ids
c. keep track token owners addresses to tokem ids 
d. keep track of how many tokens an owner address has 
e. create an event that emits a tranfer log - 
   contact addrss, where it is being minted to, the id



*/

contract ERC721 {

    event Tranfer(address indexed from, address indexed to, uint256 indexed tokenId); //creates a log
    // mapping in soldity creates a hash table of key pair values 
    // mapping from token id to the owner 
    mapping(uint256 => address) private _tokenOwner;
    // mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    function balanceOf(address _owner) public view returns (uint256) {
         require(_owner != address(0), 'token doesnt is non-existent');
         return _OwnedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) external view returns (address) {
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'token doesnt is non-existent');
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns(bool) {
        // setting the address of nft owner to check the mapping 
        //  of the address from tokenOwner at the tokenId
        address owner = _tokenOwner[tokenId];
        // return truththiness that address is not zero
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId ) internal virtual {
        // require that the address isn't zero
        require(to != address(0), 'ERC721: minting to the zero address');

        require(!_exists(tokenId), 'ERC721: token alrady minted');
        // we are adding a new address with token id for minting
            _tokenOwner[tokenId] = to;
            _OwnedTokensCount[to] += 1;

            emit Tranfer(address(0), to, tokenId);
            
    }
    

}

