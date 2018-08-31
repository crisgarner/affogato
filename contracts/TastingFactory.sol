pragma solidity ^0.4.23;

import "./Utils.sol";

contract TastingFactory is Utils{

   event LogAddCupProfile(bytes32 indexed _id);

   struct CupProfile{
        bytes32 uid;
        bytes32 aroma;
        bytes32 flavor;
        bytes32 acidity;
        bytes32 body;
        bytes32 aftertaste;
        //Precision two decimals 100.00
        uint16 cuppingNote;
    }

    mapping(address => bytes32[]) public tasterToCupProfiles;
    mapping(bytes32 => bytes32[]) public coffeeBatchToCupProfiles;
    mapping(bytes32 => CupProfile) public cupProfiles;
    uint tastingCount = 0;

    function getTasterCupProfileCount(address _taster)public view returns (uint){
        return tasterToCupProfiles[_taster].length;
    }

    function getCoffeeCupProfileCount(bytes32 _coffeeBatch)public view returns (uint){
        return coffeeBatchToCupProfiles[_coffeeBatch].length;
    }


    function addCupProfile(
        bytes32 _coffeeBatchId,
        bytes32 _aroma,
        bytes32 _flavor,
        bytes32 _acidity,
        bytes32 _body,
        bytes32 _aftertaste,
        uint16 _cuppingNote
    ) public {
        bytes32 uid = keccak256(toBytes(tastingCount));
        CupProfile memory cupProfile = CupProfile(uid,_aroma,_flavor,_acidity,_body,_aftertaste,_cuppingNote);
        tasterToCupProfiles[msg.sender].push(uid);
        coffeeBatchToCupProfiles[_coffeeBatchId].push(uid);
        cupProfiles[uid] = cupProfile;
        tastingCount++;
        emit LogAddCupProfile(uid);
    }
}