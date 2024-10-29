import { LightningElement, wire } from 'lwc';
import { gql, graphql } from "lightning/uiGraphQLApi";
export default class GraphQlPractice extends LightningElement {
    results;
    errors;
  
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
        
        this.results = data.uiapi.query.Account.edges.map((edge) => edge.node);
        console.table('data :' + this.results);
      }
      this.errors = errors;
    }
}
