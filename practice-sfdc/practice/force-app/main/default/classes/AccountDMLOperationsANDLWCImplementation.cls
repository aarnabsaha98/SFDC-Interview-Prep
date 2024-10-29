public with sharing class AccountDMLOperationsANDLWCImplementation {

    @AuraEnabled(cacheable=true)
    public static List<Account> fetchRecords(String ratingType) {
        return [SELECT Id, Name, Website, Rating FROM Account Where Rating=:ratingType];
    }

    @AuraEnabled
    public static void createRecords(String accountRecord) {

        Map<String, Object> accountToCreate = (Map<String, Object>) JSON.deserializeUntyped(accountRecord);
        
        // Create a new Account object
        Account newAccount = new Account();
        
        newAccount.Name = (String) accountToCreate.get('Name');
        newAccount.Website = (String) accountToCreate.get('Website');
        newAccount.Rating = (String) accountToCreate.get('Rating'); 
        insert newAccount;
    }

    @AuraEnabled
    public static void updateRecords(String accountRecord) {

        Map<String,String> accountToUpdate = (Map<String,String>)JSON.deserializeUntyped(accountRecord);
        String accountId = (String) accountToUpdate.get('Id');

        Account account = [SELECT Id, Name, Website, Rating FROM Account WHERE Id = :accountId LIMIT 1];

        // Check if the account was found and update the fields
        if (account != null) {
            account.Name = (String) accountToUpdate.get('Name');
            account.Website = (String) accountToUpdate.get('Website');
            account.Rating = (String) accountToUpdate.get('Rating');

            update account;
        }
    }
}