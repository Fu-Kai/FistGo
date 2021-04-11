pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

contract PersonDID {
    struct Person {
        uint8 id;
        uint8 age;
        string name;
        string experience;
    }
    
    event AddPerson(uint8 id, uint8 age, string name, uint timestamp);
    event AddPersonExperience(address ip, string experience, uint timestamp);
    event AuthorizeBasicInfo(address me, address Another, uint8 cnt, uint timestamp);
    event AuthorizeExperience(address me, address Another, uint8 cnt, uint timestamp);
    event ViewBasicInfo(address Another, uint timestamp);
    event ViewExperience(address Another, uint timestamp);
    
    Person admin;
    address adminIp;//存放管理员ip
    Person[] persons;
    mapping(address => Person) public PersonInfo;
    mapping(address=> bool) public isPersonExsist;
    
    //自定义判断是否为管理员
    modifier Onlyadmin(){
        require(msg.sender == adminIp, "You are NOT administrator!");
        _;
    }
    
    constructor (address ip, uint8 id, string memory name, uint8 age, string memory experience) public {
        adminIp = ip;
        admin = Person(id, age, name, experience);
        Person memory p = Person(id, age, name, experience);
        persons.push(p);
        PersonInfo[ip] = p;
        isPersonExsist[msg.sender] = true;
    }
    
    function getNumberOfPersons() view public returns (uint256) {
        return persons.length;
    }
    //添加个人基础信息
    function addPerson(uint8 id, uint8 age, string memory name) public returns (bool) {//不需要管理员权限
        require(!((id == 0) || age == 0), "persons info can not be empty!!");
        require(!isPersonExsist[msg.sender], "person can not exsist !!");
        Person memory person = Person(id, age, name, "");//info信息只能管理员添加
        persons.push(person);
        PersonInfo[msg.sender] = person;
        isPersonExsist[msg.sender] = true;
        emit AddPerson(id, age, name, now);
    }
    //添加个人经历信息（管理员）
    function addPersonExperience(address ip, string memory experience) public Onlyadmin returns (bool) {//需要管理员权限
        Person storage p = PersonInfo[ip];
        p.experience = experience;
        emit AddPersonExperience(ip, experience, now);
    }
    
    //存放a对b基础信息的查看次数
    mapping(address =>mapping(address => uint8)) a_BasicInfo_b;
    
    //存放a对b经历信息的查看次数
    mapping(address =>mapping(address => uint8)) a_Experience_b;



    //授权他人查看基础信息
    function authorizeBasicInfo(address ipAnother, uint8 CntOfView) public returns(bool) {
        Person memory p = PersonInfo[msg.sender];
        a_BasicInfo_b[ipAnother][msg.sender] = CntOfView;
        emit AuthorizeBasicInfo(msg.sender, ipAnother, CntOfView, now);
    }
    //查看基础信息
    function viewBasicInfo(address ipAnother) public returns(Person memory) {
        require(a_BasicInfo_b[msg.sender][ipAnother] > 0, "You've run out of viewBasicInfo cnts");
        Person memory Another = PersonInfo[ipAnother];
        Person memory p = Person(Another.id, Another.age, Another.name, "");
        a_BasicInfo_b[msg.sender][ipAnother]--;
        emit ViewBasicInfo(ipAnother, now);
        return p;
    }
    
    
    //授权他人查看个人经历
    function authorizeExperience(address ipAnother, uint8 CntOfView) public returns(bool) {
        Person memory p = PersonInfo[msg.sender];
        a_Experience_b[ipAnother][msg.sender] = CntOfView;
        emit AuthorizeExperience(msg.sender, ipAnother, CntOfView, now);
    }
    //查看经历信息
    function viewExperience(address ipAnother) public returns(string memory) {
        require(a_Experience_b[msg.sender][ipAnother] > 0, "You've run out of viewExperience cnts");
        a_Experience_b[msg.sender][ipAnother]--;
        emit ViewExperience(ipAnother, now);
        return PersonInfo[ipAnother].experience;
    }
    
}