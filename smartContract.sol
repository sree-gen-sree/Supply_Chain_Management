pragma solidity >=0.4.22 <0.7.0;

contract Supplychain  {
    enum gender {male, female}


mapping(uint => string) public certificateHash;
   
    function setCertificate(uint _id, string memory _certificateHash) public {
        certificateHash[_id] = _certificateHash;
    }
     function getCertificate(uint _id) public view returns (string memory _certificateHash ) {
       _certificateHash = certificateHash[_id] ;
    }
}