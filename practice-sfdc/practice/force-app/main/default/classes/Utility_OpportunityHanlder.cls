public with sharing class Utility_OpportunityHanlder {

    public static void updateAccountDescription(List<Opportunity> oppList, Map<Id, Opportunity> oppMap) {

        Map<Id, String> oppAmountMap = new  Map<Id, String>();
        Opportunity oldOpp = new Opportunity();
        Set<Id> accIds = new  Set<Id>();
        for(Opportunity opp: oppList){  

            // update 
            if(oppMap != null){
                oldOpp = oppMap.get(opp.Id);

                if(oldOpp.AccountId != opp.AccountId){
                    accIds.add(opp.AccountId);
                    accIds.add(oldOpp.AccountId);
                } else if(oldOpp.Amount != opp.Amount){
                    accIds.add(opp.AccountId);
                }
            }
            // Insert 
            else {
                accIds.add(opp.AccountId);
            }
        }


        List<Opportunity> opplists = [SELECT Id, Name, AccountId, Amount from Opportunity where AccountId IN :accIds and Amount != null];
        Map<Id, Opportunity>  oppMaps = new Map<Id, Opportunity>();

        for(Opportunity oppl : opplists){
            if(!oppMaps.containsKey(oppl.AccountId) || oppl.Amount > oppMaps.get(oppl.AccountId).amount){
                oppMaps.put(oppl.AccountId, oppl);
            }
        }

        List<Account> acclist = [SELECT ID, NAME , Description FROM Account WHERE ID IN: oppMaps.keySet()];
        List<Account> updateAcc = new List<Account>();
        for(Account a : acclist){
            a.Description = 'Heighest amount of the Opportunity account :'  + oppMaps.get(a.Id).Name;
            updateAcc.add(a);
        }

        update updateAcc;
    }
}