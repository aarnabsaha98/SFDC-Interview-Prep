import { LightningElement, track, wire } from 'lwc';
import fetchAccount from '@salesforce/apex/AccountDMLOperationsANDLWCImplementation.fetchRecords';
import createAccount from '@salesforce/apex/AccountDMLOperationsANDLWCImplementation.createRecords';
import updateAccount from '@salesforce/apex/AccountDMLOperationsANDLWCImplementation.updateRecords';


export default class CrudImplmentationINLWC extends LightningElement {

    rating = 'Hot';
    @track accounts = []; 

    @wire(fetchAccount, { ratingType: '$rating' })
    wiredAccount(result){
        let {data, error} = result;
        if(data){
            this.accounts = data;
        } else{
            console.log(error);
        }
    }

    
}