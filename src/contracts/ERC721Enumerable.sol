// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721{
    // abstract contract does not have anything it just function signatures
    uint256[] private _allTokens;

// mapping from tokenId to position in _allTokens array 
    mapping(uint256 => uint256) private _allTokenIndex; 
// mapping of owner to list of all owner token ids    
    mapping(address => uint256[]) _ownedTokens;
// mapping from token ID index of the owner token list 
    mapping(uint256 => uint256 ) private _ownedTokensIndex;

    function _mint(address to, uint256 tokenId) internal override(ERC721){
        super._mint(to, tokenId);
        // 2 things 
        // A add tokens to the owner
        // B all tokens to our total supply - to allTokens

        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);

    }

    // add tokens to the _allToken array and set the position o f

    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
        _allTokenIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
            // 1. add address and tokenId to the ownedTokens
            _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
            _ownedTokens[to].push(tokenId);
            // 2. owneTokensIndex tokenId set to address of ownedTokens position 
            // 3. we want to execute the funtion with minting 
            // copile and migrate
    }

    function tokenByIndex(uint256 index) public view returns(uint256){
        // make sure that the index is not out of bounds of the total supply
        require(index < totalSupply(), 'global index is out of bounds');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint256){
        require(index < balanceOf(owner), 'owner index is out of bounds'); 
        return _ownedTokens[owner][index];
    }
// return the total supply of the _allTokens array
    function totalSupply() public view returns(uint256) {
        return _allTokens.length;
    }

}