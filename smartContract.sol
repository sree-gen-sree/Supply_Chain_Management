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
    struct actorsProfile {
        string name;
        uint256 phone;
        gender actorGender;
        string actorAddress;
        string password;
        string actorType;
    }
    mapping(uint256 => actorsProfile) actor;
    mapping(uint256 => uint256) public certificatieCount;

    function setActorProfile(
        string memory _name,
        uint256 _phone,
        gender _actorGender,
        string memory _actorAddress,
        string memory _password,
        string memory _actorType

    ) public {
        actor[_phone] = actorsProfile(
            _name,
            _phone,
            _actorGender,
            _actorAddress,
            _password,
            _actorType
        );
    }

    function getActorProfile(uint256 _phone)
        public
        view
        returns (
            string memory _name,
            gender _actorGender,
            string memory _actorAddress
        )
    {
        _name = actor[_phone].name;
        _actorGender = actor[_phone].actorGender;
        _actorAddress = actor[_phone].actorAddress;
    }
    function getLogin(uint256 _phone)
        public
        view
        returns (string memory _password, string memory _actorType)
    {
        _password = actor[_phone].password;
        _actorType = actor[_phone].actorType;
    }

    string id;
    address public previousOwner;
    address public manufacturerAddress;

    struct Product {
        string name;
        string quantity;
        string ingredients;
        bool initialized;
        address[] owners;
    }

    mapping(string => Product) private ProductMap;

    mapping(address => mapping(string => bool)) private OwnerMap;

    event CreateProduct(address account, string uid, string ingredients);

    event TransferProduct(address from, address to, string uid);

    event RejectProduct(address from, string uid, string message);
    event RejectTransfer(address from, string uid, string message);

    constructor() public {
        manufacturerAddress = msg.sender;
    }

    modifier onlyManufacturer() {
        require(msg.sender == manufacturerAddress,"UnAuthorized Access");
        _;
    }


}