public with sharing class GetRecordsForWirePracticeLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getRecords(){
        try {
            return [SELECT id,name, website FROM Account LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}