public with sharing class AccountBatchClass implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id from account'); 
    }
    public void execute(Database.BatchableContext bc, list<sObject> slist) {}
    public void finish(Database.BatchableContext bc){}
}
