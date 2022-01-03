contract FunnyBank  {
    uint number_of_accounts;
        //get_balance()
    //withdrawl
    //transfer
    //Depositing: recive()
        //Todo:
    //register accounts
    //onlyregisterd Modifer
    // new mapping forKYC
    // KYC struct 
    // number_of_accounts
mapping(address=>uint) account_balances;
mapping(address=>uint) account_info_map;

struct BankAccountRecord{
    uint account_number;
    string fullName;
    string profession;
    string DateOfBirth;
    address wallet_address;
    string customer_address;

}
BankAccountRecord[] bankAccountRecord;

function register_aacount(
    string memory fullName_, 
    string memory profession_, 
    string memory DateOfBirth_, 
    string memory customer_address_) external {

require(account_info_map[msg.sender]==0,"Account already registered");

bankAccountRecord.push(
    BankAccountRecord({
        account_number:++number_of_accounts,
        fullName:fullName_,
        profession:profession_,
        DateOfBirth:DateOfBirth_,
        wallet_address:msg.sender,
        customer_address:customer_address_

        })
    );
    account_info_map[msg.sender]=number_of_accounts;
}


    modifier onlyReistered() {
        require(account_info_map[msg.sender]>0, "User not Register,please register");
        _;
    }
    
    function get_balance() external view onlyReistered returns(uint) {
        account_balances[msg.sender];
    }

    function transfer(uint amount, address acctToTransferTo) public onlyReistered {
       //msg.receiver;
        account_balances[msg.sender] -= amount;
        account_balances[acctToTransferTo] += amount;
    }
    function withdrawl (uint amount) public onlyReistered{ 
        account_balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
    receive()external payable{
        account_balances[msg.sender] += msg.value;
        }
  
}
