public with sharing class Utility_AccountHanlder {

    private static final String HANDLER_NAME = 'AccountTrigger_Handler';

    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts(String phone){
        return [SELECT Name,Website, Phone  From Account WHERE Phone != :phone];   
    }

    public static void updateName(List<Account> accList) {
        for(Account acc: accList) {
            acc.Name = 'New Account -- Arnab';
        }
    }

    public static void createAccount() {

        TriggerHandler.bypass(HANDLER_NAME);

        Account acc = new Account(Name = 'Cool Account -- Saha');
        insert acc;

        TriggerHandler.clearBypass(HANDLER_NAME);
    }

    // String email = acc.Email;
    // if (email != null && !email.isEmpty()) {
    //     int indexOfAtSign = email.indexOf('@');
    //     if (indexOfAtSign > 0   && indexOfAtSign ) {
    //         // I want a string from 0th index to indexOfAtSign
    //         String nameFromEmail = email.substring(0,indexOfAtSign);
    //         acc.Name = nameFromEmail;
    //     }
    // }


    public static void updateCountryFieldOnContact(List<Account> newAccList, Map<Id, sObject> oldAccMap){

        Map<Id, String> accCountryMap = new Map<Id, String>();
        List<Contact> updateContact = new List<Contact>();
        List<Contact> conlist = new List<Contact>();

        for(Account account : newAccList){

            if(oldAccMap != null){
                // update
                Account oldAcc = (Account)oldAccMap.get(account.id);
                if(account.Country__c != oldAcc.Country__c){
                    accCountryMap.put(account.id, account.Country__c);
                } 
            } else {
                // insert
                accCountryMap.put(account.id, account.Country__c);
            }

        }
        if(!accCountryMap.isEmpty()){
            conlist = [SELECT ID, Name, Country__c, AccountId FROM Contact WHERE AccountId IN : accCountryMap.keySet()];
        }

        if(!conlist.isEmpty()){
            for(Contact c : conlist){
                c.Country__c = accCountryMap.get(c.AccountId);
                updateContact.add(c);
            }
        }

        update updateContact;
    }

    public static void createContactFromAccount(List<Account> newAccList , Map<Id, Account>oldAccMap){


        List<Contact> conlist = new List<Contact>();
        if(newAccList.size() != 0){
            for(Account acc : newAccList){

                if(oldAccMap != null){
                    Account oldAccount = (Account)oldAccMap.get(acc.id);
                    if(oldAccount.Create_Contact__c == false && acc.Create_Contact__c == true){
                        Contact con = new Contact(LastName = acc.Name, FirstName = 'Contact-',  Phone = acc.Phone, AccountId = acc.Id);
                        conlist.add(con);
                    }
                } else {
                    if(acc.Create_Contact__c == true){
                        Contact con = new Contact(LastName = acc.Name, FirstName = 'Contact-',  Phone = acc.Phone, AccountId = acc.Id);
                        conlist.add(con);
                    }
                }
            }
        }
        insert conlist;

    }

    /*
    When an Account gets updated, send email to the account's 
    owner with the details fo the conract modified b/w the last update and current update of account 
    */
    public static void sendEmailWithUpdatedContacts(List<Account> newAccList, Map<Id, Account> oldAccMap){

        List<Id> accSet = new List<Id>();
        Map<Id, Datetime> oldLastModifiedMap = new Map<Id, Datetime>();
        Map<Id, Datetime> newLastModifiedMap = new Map<Id, Datetime>();
    
        for(Account acc : newAccList){
            Account oldAccount = oldAccMap.get(acc.Id);
            if(oldAccount != null){
                oldLastModifiedMap.put(acc.Id, oldAccount.LastModifiedDate);
                newLastModifiedMap.put(acc.Id, acc.LastModifiedDate);
                accSet.add(acc.Id);
            }
        }
    
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<Contact> conList = [SELECT Id, Name, AccountId, LastModifiedDate, Email FROM Contact WHERE AccountId IN :accSet];
    
        for(Contact con : conList){
            Datetime oldLastModifiedDate = oldLastModifiedMap.get(con.AccountId);
            Datetime newLastModifiedDate = newLastModifiedMap.get(con.AccountId);
            
            if(con.LastModifiedDate > oldLastModifiedDate && con.LastModifiedDate <= newLastModifiedDate){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {'aarnabsaha98@gmail.com'};
                mail.setToAddresses(toAddresses);
                mail.setSubject('Send Email --> subject');
                mail.setPlainTextBody('Hi, Arnab. Updated Contact: ' + con.Name);
                mails.add(mail);
            }
        }
    
        if(!mails.isEmpty()){
            Messaging.sendEmail(mails);
        }
    }
    
}