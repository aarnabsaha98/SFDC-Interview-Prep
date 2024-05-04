public with sharing class SellCiderMain {
    private BearORG bgm;
    public BrewBearMain(BearORG bg){
        this.bgm = bg;
    }

    public void execute(){
        bgm.SellCider();        
    }
}