import { LightningElement, track, wire } from 'lwc';
// import getAccounts from '@salesforce/apex/Utility_AccountHanlder.getAllAccounts'
import { gql, graphql } from "lightning/uiGraphQLApi";

export default class CreateAccountDataTableWPagination extends LightningElement {

    columns = [
        { label: 'Label', fieldName: 'Name', editable: true },
        { label: 'Website', fieldName: 'Website', type: 'url', editable: true },
        { label: 'Phone', fieldName: 'Phone', type: 'Picklist', editable: true },
        { label: 'Rating', fieldName: 'Rating', type: 'Picklist', editable: true },
    ]

    rows = [];
    @track draftValues = [];
    phoneNumber = null;
    total_no_recs_per_page = 5;
    @track currentPage = 1;

    accType = '%Direct';
    accRatting = 'Hot'


    // connectedCallback() {
    //     getAccounts({ Phone: this.phoneNumber })
    //         .then(res => {
    //             this.rows = res;
    //         })
    //         .catch(error => {
    //             console.error(error);
    //         });
    // }

    @wire(graphql, {
        query: gql`
  query AccountLists($accType: Picklist, $accRatting: Picklist) {
    uiapi {
      query {
        Account(
          where: {
            and: [
              { Phone: { ne: "" } }, 
              { Type: { like: $accType } }, 
              { Rating: { eq: $accRatting } }
            ]
          }
          orderBy: { Name: { order: ASC } }
        ) {
          edges {
            node {
              Id
              Name {
                value
              }
              Website {
                value
              }
              Phone {
                value
              }
              Type {
                value
              }
              Rating {
                value
              }
            }
          }
        }
      }
    }
  }
  
        `,
    })
    graphqlQueryResult({ data, errors }) {
        if (data) {

            this.rows = data.uiapi.query.Account.edges.map((edge) => edge.node);
            console.table('data :' + this.results);
        }
        console.log(errors);
    }


    get totalPages() {
        return Math.ceil(this.rows.length / this.total_no_recs_per_page);
    }

    get paginatedRows() {
        const start = (this.currentPage - 1) * this.total_no_recs_per_page;
        const end = start + this.total_no_recs_per_page;
        return this.rows.slice(start, end);
    }

    prevPage() {
        if (this.currentPage > 1) {
            this.currentPage--;
        }
    }

    nextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage++;
        }
    }

    get isFirstPage() {
        return this.currentPage === 1;
    }

    get isLastPage() {
        return this.currentPage === this.totalPages;
    }

    selectAllCheckboxes(event) {
        const row = event.detail.row;
        console.log('row :' + row);
    }


    handleSave(event) {
        const updatedFields = event.detail.draftValues;
        console.log(updatedFields);
    }
}