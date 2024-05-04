public with sharing class BrewBearMain implements IBrewBear{

    private BearORG bgm;
    public BrewBearMain(BearORG bg){
        this.bgm = bg;
    }

    public void execute(){
        bgm.BrewBear();        
    }
}