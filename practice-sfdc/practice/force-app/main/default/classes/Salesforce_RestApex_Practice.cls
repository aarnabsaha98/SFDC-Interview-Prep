@RestResource(urlMapping = '/Accounts')
global with sharing class Salesforce_RestApex_Practice {


    global class AccountWrapper{
        global List<Account> accounts;
        global List<Contact> contacts;
    }

    global class AccountInformation{
        global Account accoundRecord {get; set;}
        global Contact contactRecord {get; set;}

    }

    @HttpGet
    global static AccountWrapper getAccounts() {

        Map<String, String> accIndustryMap = RestContext.request.params;
        String accIndustry = accIndustryMap.get('Industry');
        System.debug('accIndustry : ' + accIndustry);
        List<Account> accList =  [SELECT Id, Name, Industry from Account WHERE Industry= :accIndustry ORDER BY CreatedDate DESC lIMIT 5];

        Set<String> accIdSet = new Set<String>();
        for(Account acc: accList) {
            accIdSet.add(acc.Id);
        }

        List<Contact> conList =  [SELECT Id, Name, AccountId from Contact WHERE AccountId In : accIdSet];
        AccountWrapper accwrapper = new AccountWrapper();
        accwrapper.accounts = accList;
        accwrapper.contacts = conList;

        return accwrapper;
    }

    @HttpPost
    // global static String createAccount(String accountName , String website) {

    //     Account acc = new Account(Name = accountName, website = website);
        
    //     insert acc;
    //     return 'Account inserted Successfully ' + acc.Id;
    // }
    global static String createAccount_Contact(AccountInformation info){
        Account accRecords = info.accoundRecord;
        Contact conRecords = info.contactRecord;


            insert accRecords;
            conRecords.accountId = accRecords.Id;
            insert conRecords;

        return 'success';

    }




}