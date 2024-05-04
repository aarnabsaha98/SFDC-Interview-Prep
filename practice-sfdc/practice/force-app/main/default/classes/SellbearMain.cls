public with sharing class SellbearMain implements IBrewBear{

    private BearORG bgm;
    public SellbearMain(BearORG bg){
        this.bgm = bg;
    }

    public void execute(){
        bgm.SellBear();        
    }
}