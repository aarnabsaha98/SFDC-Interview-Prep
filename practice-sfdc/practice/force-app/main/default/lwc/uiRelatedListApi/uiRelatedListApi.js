import { LightningElement, wire  } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

export default class GetRelatedRecords extends LightningElement {
    error;
    records;
    
    @wire(getRelatedListRecords, {
      parentRecordId: '001RM000003UNu6YAG',
      relatedListId: 'Contacts',
      fields: ['Contact.Id', 'Contact.Name'],
      where: '{ Name: { like: "Bob%" }}',
    })
    listInfo({ error, data }) {
      if (data) {
        this.records = data.records;
        this.error = undefined;
      } else if (error) {
        this.error = error;
        this.records = undefined;
      }
    }
  }