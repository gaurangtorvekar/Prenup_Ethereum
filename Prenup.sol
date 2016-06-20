// Prenupwithlove.com
// This contract has been created by Gaurang Torvekar, the co-founder and CTO of Attores, a Singaporean company which is creating a SaaS platform for Smart Contracts
// This is a fun prenup for the wedding of Gaurang and Sayalee, planning to get married in December 2016

contract prenup{
	string public marriageStatus;
	string public marriageDate;
    string public ipfsHash;
	string public theHusband;
	string public theWife;
	address public husbandAddress;
	address public wifeAddress;
	address owner;
	uint amountInContract;
	uint public constant WEI_PER_ETHER = 1000000000000000000;

	bool public isSigned;
	bool wifeSigned;
	bool husbandSigned;

    // This is the constructor, called while creating the contract
	function prenup(string _marriageStatus, string _marriageDate, string _ipfsHash, address _owner, string _theHusband, string _theWife, address _husbandAddress, address _wifeAddress){
		marriageStatus = _marriageStatus;
		marriageDate = _marriageDate;
		ipfsHash = _ipfsHash;
		theHusband = _theHusband;
		theWife = _theWife;
		husbandAddress = _husbandAddress;
		wifeAddress = _wifeAddress;
		owner = _owner;
		amountInContract += msg.value;
	}

    // This is a function called by both the husband and wife to accept the terms of the document denoted by ipfsHash
	function accept(){
	    amountInContract += msg.value;
		if(msg.sender == husbandAddress){
			husbandSigned = true;
			if (wifeSigned == true){
				isSigned = true;
			}
		}
		if(msg.sender == wifeAddress){
			wifeSigned = true;
			if (husbandSigned == true){
				isSigned = true;
			}
		}
	}
	
	modifier ifOwner() { 
        if (owner != msg.sender) {
            throw;
        } else {
            _
        }
    }
    
    // A function to change the Marriage status of the contract
    function changeStatus(string _status) ifOwner{
        marriageStatus = _status;
    }
    
    // A function to change the hash of the document in case we decide to update the covenants
    function changeIPFSHash(string _hash) ifOwner{
        ipfsHash = _hash;   
        isSigned = false;
    }
    
    // Fallback function which increases the variable 
    function(){
        amountInContract += msg.value;
    }
    
    // A withdraw function just in case someone sends Ether to this contract
    function withdraw() ifOwner{
        uint amountReturned = amountInContract - (WEI_PER_ETHER * 2/10);
        owner.send(amountReturned);
    }
    	
}
