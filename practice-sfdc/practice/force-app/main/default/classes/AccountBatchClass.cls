public with sharing class AccountBatchClass implements Database.Batchable<Account>{

    private List<Account> failedRecords = new List<Account>();
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id from account'); 
    }
    public void execute(Database.BatchableContext bc, list<sObject> slist) {

        for(Account acc: slist){
            acc.Description = 'Hi new batch class';

        }
        // false -- represents allOrNone i.e. their may be all records may not succeeds or fails
        
        //Database.SaveResult[] res = Database.update(accList);
        // use this one,,, 
        Database.SaveResult[] results = Database.update(accList, false);
        

        for (Integer i = 0; i < results.size(); i++) {
            if (!results[i].isSuccess()) {
                // Add failed records to the failedRecords list
                failedRecords.add(accList[i]);
            }
        }
    }
    public void finish(Database.BatchableContext bc){
        if (!failedRecords.isEmpty()) {
            // Handle failed records (e.g., log errors, send notifications, retry logic, etc.)
            System.debug('Failed Records: ' + failedRecords);
        }
    }
}
