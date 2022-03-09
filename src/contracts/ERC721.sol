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
    event Approval (
        address indexed owner,
        address indexed approved,
        uint256 indexed tokenId
    );

    mapping(uint256 => address) private _tokenOwner;
    // mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;
    // mapping from token id to the owner
    mapping(uint256 => address) private _tokenApprovals;

    function balanceOf(address _owner) public view returns (uint256) {
         require(_owner != address(0), 'token doesnt is non-existent');
         return _OwnedTokensCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address) {
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

     function _transferFrom(address _from, address _to, uint256 _tokenId) internal {

         require(_to != address(0), 'Error - ERC721 Transfer to the zero address');
         require(ownerOf(_tokenId) == _from, 'Trying to tranfer a token the address does not own!' );

         _OwnedTokensCount[_from] -= 1;
         _OwnedTokensCount[_to] += 1;
         _tokenOwner[_tokenId] = _to;

         emit Tranfer(_from, _to, _tokenId);
     }
    

     function transferFrom(address _from, address _to, uint256 _tokenId) public { 
         require(isApprovedOrOwner(msg.sender, _tokenId));
         _transferFrom(_from, _to, _tokenId);
     }

    // require that person approving is the owner
    // approve address to a token (tokenId)
    // require that we cant approve sending tokens of the owner to the owner (current caller)
    // updat the map of the approval addresses 

     function approve(address _to, uint256 tokenId) public {
         address owner = ownerOf(tokenId);
         require(_to != owner, "Error - approval to current owner");
         require(msg.sender == owner, 'Current caller is not the owner of tokenId');
         _tokenApprovals[tokenId] = _to;
         emit Approval(owner, _to, tokenId);

     }

     function isApprovedOwner(address spender, uint256 tokenId) internal view returns(bool){
         require(_exists(tokenId), 'token does not exist');
         address owner = ownerOf(tokenId);
         return(spender == owner);
     }


    /// @notice Change or reaffirm the approved address for an NFT
    /// @dev The zero address indicates there is no approved address.
    ///  Throws unless `msg.sender` is the current NFT owner, or an authorized
    ///  operator of the current owner.
    /// @param _approved The new approved NFT controller
    /// @param _tokenId The NFT to approve

    

}

