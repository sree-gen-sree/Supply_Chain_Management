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

function createProduct(
        string memory _uid,
        string memory _name,
        string memory _quantity,
        string memory _ingredients
    ) public  {
        if (!ProductMap[_uid].initialized) {
            ProductMap[_uid] = Product(
                _name,
                _quantity,
                _ingredients,
                true,
                new address[](0)
            );

            ProductMap[_uid].owners.push(msg.sender);

            OwnerMap[msg.sender][_uid] = true;

            emit CreateProduct(msg.sender, _uid, _ingredients);
        } else {
            emit RejectProduct(
                msg.sender,
                _uid,
                "Product with given ID already exists"
            );
        }
    }

    function displayProduct(string memory _uid)
        public
        view
        returns (
            string memory _name,
            string memory _quantity,
            string memory _ingredients
        )
    {
        if (ProductMap[_uid].initialized) {
            return (
                ProductMap[_uid].name,
                ProductMap[_uid].quantity,
                ProductMap[_uid].ingredients
            );
        }
    }
    function transferProduct(
        address _from,
        address payable _to,
        string memory _uid
    ) public payable {
        require(
            (ProductMap[_uid].initialized),
            "No product with this unique ID exists"
        );
     


        //transfering amount to _to address
        _to.transfer(msg.value);

        previousOwner = _from;

        OwnerMap[msg.sender][_uid] = false;
        OwnerMap[_from][_uid] = true;

        ProductMap[_uid].owners.push(_from);
        // The next owner's address pushed to owners array.
        emit TransferProduct(msg.sender, _to, _uid);
    }  

    function displayOwner(string memory _uid)
        public
        view
        returns (address[] memory owner)
    {
        if (ProductMap[_uid].initialized) {
            return ProductMap[_uid].owners;
        }
    }
}



