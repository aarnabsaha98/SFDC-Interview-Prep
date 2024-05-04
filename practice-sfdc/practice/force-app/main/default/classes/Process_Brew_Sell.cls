public with sharing class Process_Brew_Sell {


    public static void  Brew_Sell(List<IBrewBear> brelist) {
        
        for(IBrewBear ib : brelist) {
            ib.execute();
        }
    }


}