import { LightningElement, track, wire } from 'lwc';
import { getRecords } from "lightning/uiRecordApi";

// import USER_NAME_FIELD from "@salesforce/schema/User.Name";
// import USER_EMAIL_FIELD from "@salesforce/schema/User.Email";
import NAME_FIELD from "@salesforce/schema/Account.Name";
import Website_FIELD from "@salesforce/schema/Account.Website";
import Email_FIELD from "@salesforce/schema/Account.Email__c";

import getRecordIds from '@salesforce/apex/GetRecordsForWirePracticeLWC.getRecords';

export default class WirePracticePart2 extends LightningElement {

  Ids = [];
  @track filteredData = [];
  @track accounts;
  parameterObject;

  @wire(getRecordIds)
  getRecordsIdsFromApex({ error, data }) {
    if (error) {
      console.error('Error retrieving records: ', error);
    } else if (data) {
      console.log('Data received: ', data);
      if (data.length > 0) {
        data.forEach(record => this.Ids.push(record.Id));
        this.accounts = data;
        this.parameterObject = [];
        this.accounts.forEach((acc) => {
          this.parameterObject.push({
            recordIds: [acc.Id],
            fields: [NAME_FIELD, Email_FIELD, Website_FIELD],
          });
        });
      } else {
        console.log('No records found.');
      }
    }
  }

  // @wire(getRecords, {
  //   records: [
  //     {
  //       recordIds: ['001IU00002mg8kGYAQ', '001IU00002o2LfGYAU'],
  //       fields: [NAME_FIELD],
  //       optionalFields: [Email_FIELD, Website_FIELD],
  //     }
  //   ],
  // })
  // wiredRecords({error, data}){
  //   if(error){
  //     console.log(error);
  //   } else {
  //     console.table('data' + JSON.stringify(data));
  //     this.records = data;
  //   }
  // }

  @wire(getRecords, { records: "$parameterObject" })
  wiredRecords({ error, data }) {
    if (data) {
      data.results.forEach((record) => {
        this.filteredData.push({
          Name: record.result.fields.Name.value,
          Website: record.result.fields.Website.value,
          Id: record.result.id,
        });
        console.log('filtered data : ' +JSON.stringify(this.filteredData) );
      });
    } else if (error) {
      console.log("error: ", error);
    }
  }
}