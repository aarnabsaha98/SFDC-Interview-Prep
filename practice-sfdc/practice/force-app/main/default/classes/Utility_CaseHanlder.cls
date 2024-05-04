public with sharing class Utility_CaseHanlder {

    public static void linkCaseWithContact(List<Case> newCaseList , Map<Id, sObject> caseOldMap){

        Map<String, Case> suppliedEmailCaseMap = new  Map<String, Case>();
        
        for(Case c : newCaseList){
            if(caseOldMap != null){
                Case oldCase = (Case)caseOldMap.get(c.id);
            
                if(c.SuppliedEmail != '' && c.SuppliedEmail != oldCase.SuppliedEmail){

                    suppliedEmailCaseMap.put((String)c.SuppliedEmail , c);
                }
            } else {
                suppliedEmailCaseMap.put((String)c.SuppliedEmail , c);
            }
        }

       List<Contact> conlist = [SELECT ID, Name, Email FROM Contact WHERE Email IN : suppliedEmailCaseMap.keySet()];
       List<Case> caseLst =  [SELECT ID, ContactId, SuppliedEmail FROM Case WHERE SuppliedEmail IN : suppliedEmailCaseMap.keySet()];
       Map<String, Contact> conEmailMap = new Map<String, Contact>();
       List<Case> updateCaseLst =  new List<Case>();

       if(conlist.size() != 0){
        for(Contact c :conlist){
            conEmailMap.put(c.Email, c);
           }
    
        System.debug('logLevel :'+ conlist );
       }

        for(Case c :caseLst) {
            if(conEmailMap.containsKey(c.SuppliedEmail)){
                c.ContactId = conEmailMap.get(c.SuppliedEmail).Id;
                updateCaseLst.add(c);
            }
        }
       update updateCaseLst;
    }

    public static void createTaskWithPrimaryContactOfAccount(List<Case> newCaseList , Map<Id, sObject> caseOldMap){
        Set<Id> accIds = new Set<Id>(); 
        List<Task> tasKList = new List<Task>();
        if(newCaseList!= null){
            for(Case c : newCaseList){
                if(caseOldMap != null){
                    Case oldCase = (Case)caseOldMap.get(c.Id);
                    if((c.AccountId != null && 
                    (oldCase.AccountId == c.AccountId || oldCase.AccountId != c.AccountId)) 
                    &&(oldCase.Create_Task__c == false && c.Create_Task__c != oldCase.Create_Task__c)){
                        accIds.add(c.AccountId);
                        Task tsk = new Task(Status = 'Not Started' , Subject = 'Call', Priority = 'Normal', WhatId = c.AccountId);
                        tasKList.add(tsk);

                    }
                } else {
                    if(c.AccountId != null && c.Create_Task__c == true){
                        accIds.add(c.AccountId);
                        Task tsk = new Task(Status = 'Not Started' , Subject = 'Call', Priority = 'Normal', WhatId = c.AccountId);
                        tasKList.add(tsk);
                    }
                }
            }
        }
        insert tasKList;

        List<Contact> conlist = [SELECT ID, NAME, AccountId, Primary_Contact__c  FROM Contact WHERE  Primary_Contact__c = true and AccountId IN :accIds ];
        Map<Id , Contact> primaryContact = new Map<Id , Contact>();
        for(Contact con : conlist){
            if(con.Primary_Contact__c){
                primaryContact.put(con.AccountId, con);
            }
        }

        List<Task> taskll = [SELECT ID, Subject, Status, Priority, WhatId, WhoId  FROM Task WHERE  AccountId IN :accIds];
        List<Task> updatetask = new List<Task>();
        for(Task t :taskll){
            t.WhoId = primaryContact.get(t.WhatId).Id;
            updatetask.add(t);
        }
        update updatetask;
    }
}