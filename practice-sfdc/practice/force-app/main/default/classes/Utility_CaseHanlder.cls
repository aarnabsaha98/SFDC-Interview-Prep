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


    //Q1. write a trigger that creates a Task and send an email to the Account's owner whenEver case is deleted from account.

    public static void sendEmailToAccountOwner(List<Case> caselist){
        Set<Id> caseAccountIdSets = new Set<Id>();
        List<Task> taskList = new List<Task>();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Map<Id, String> accOwnerEmailMap = new Map<Id, String>();

		for(Case cs :caselist){
			caseAccountIdSets.add(cs.AccountId);
			Task tsk = new Task(WhatId = cs.AccountId, WhoId = cs.ContactId); 
			taskList.add(tsk);
		}
	    
        
        List<Account> accList =  [SELECT ID, NAME, Owner.Email FROM Account WHERE ID IN : caseAccountIdSets];

        for(Account acc :accList){
            accOwnerEmailMap.put(acc.Id, acc.Owner.Email);
        }

	    if(!taskList.isEmpty()){
		    insert taskList;
	    }

	    for(Task tsk : taskList){
            if(accOwnerEmailMap.get(tsk.WhatId) != null){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {accOwnerEmailMap.get(tsk.WhatId)};
                mail.setToAddresses(toAddresses);
                mail.setSubject('Send Email --> subject');
                mail.setPlainTextBody('Hi, Arnab');
                mails.add(mail);
            }
		    
	    }
	

	    if(!mails.isEmpty()){
            Messaging.SendEmail(mails);
        }
        
        
    }

    /* Whenever a child case record is closed, we need to check it's parent case and 
    if all child of that parent case are closed, we need to close the parent case as well.
    */

    public static void checkCaseStatusOnParent(List<Case> caselist) {
        Set<Id> parentIds = new Set<Id>();
    
        // Collect parent case IDs
        for (Case c : caselist) {
            if (c.Status == 'Closed' && c.ParentId != null) {
                parentIds.add(c.ParentId);
            }
        }
    
        if (parentIds.isEmpty()) return;
    
        // Query parent cases
        Map<Id, Case> parentCaseMap = new Map<Id, Case>(
            [SELECT Id, Status FROM Case WHERE Id IN :parentIds]
        );

        // get all the childCase and check all the child case status is closed or not
        List<Case> childCases = [SELECT Id, ParentId, Status FROM Case WHERE ParentId IN :parentIds];
        Boolean isAllClosed = true;
        for(Case cc : childCases){
            if(cc.Status != 'Closed'){
                isAllClosed = false;
            }
        }
        
        // Update parent case status
        if(isAllClosed){
            for (Id parentCaseId : parentCaseMap.keySet()) {
                Case parentCase = parentCaseMap.get(parentCaseId);
                parentCase.Status = 'Closed';
            }
        }

        update parentCaseMap.values();
       
    }
    
    
}