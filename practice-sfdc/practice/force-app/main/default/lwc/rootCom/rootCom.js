import { LightningElement , api} from 'lwc';
import getAccounts from '@salesforce/apex/Utility_AccountHanlder.getAllAccounts'

export default class RootCom extends LightningElement {

    rule_1 = '';
    rule_2 = '';
    rule_3 = '';
    rule_4 = '';
    _nameOfLCH = ''; // this indicates it is a private variable!!

    constructor(){
        super();
        /*𝗥͟𝗨͟𝗟͟𝗘͟𝗦

        We can not access any HTML element inside the constructor life-cycle-hook
        we can modify any property 
        We can call Apex
        We can not create/update custom event
        */

    
        // this.template.querySelector('.text').textContent = this.rule_1;

        this.rule_1 = 'We can not access Element inside the constructor';

        this.rule_2 = 'We can call the apex class'
        this.rule_3 = 'Any property can be modified'
        this.rule_4 = 'We can not create/update custom event'
        
        getAccounts()
        .then(res=>{
            console.table(res);
        })
        .catch(err=>{
            console.log(err);
        })

    }

    // Add a layer of abstrcution!!
    get lifeCycleHookName(){
        return this._nameOfLCH;
    }

    set lifeCycleHookName(value){
        this._nameOfLCH = value 
    }


    handleName(event){
        this.lifeCycleHookName = event.target.value;
    }

   
}