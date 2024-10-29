public with sharing class AccountTrigger_Handler extends TriggerHandler{
    
    public override void beforeInsert(){
        //Utility_AccountHanlder.updateName(Trigger.new);
        //Utility_AccountHanlder.createAccount();
    }
    public override void afterInsert(){
        //Utility_AccountHanlder.updateCountryFieldOnContact(Trigger.new, null);
    }
    public override void afterUpdate(){
        //Utility_AccountHanlder.updateCountryFieldOnContact(Trigger.new, Trigger.oldMap);
        Utility_AccountHanlder.sendEmailWithUpdatedContacts(Trigger.new, Trigger.oldMap);
    }
    
    public override void beforeDelete(){
        //Utility_AccountHanlder.storeAssosiatedContactsBeforeAccountDelete(Trigger.old);
    }
}