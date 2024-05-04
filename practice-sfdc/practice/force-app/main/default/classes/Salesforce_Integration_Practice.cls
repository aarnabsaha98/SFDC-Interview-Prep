public with sharing class Salesforce_Integration_Practice {
    private static final String DUMMY_USER_URI = 'https://jsonplaceholder.typicode.com/users';

    public static List<User_Wrapper> getUsers() {
        List<User_Wrapper> users = new List<User_Wrapper>();

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(DUMMY_USER_URI);
        req.setMethod('GET');

        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            users = User_Wrapper.parse(res.getBody());
        }
        System.debug('users: '+ users);
        return users;
    } 

    public static void createContact(List<User_Wrapper> users){
        List<Contact> contacts = new List<Contact>();
        for(User_Wrapper user : users){
            Contact con = new Contact( 
            LastName = user.name,
            email = user.email ,
            MailingCity	= user.address.city,
            MailingStreet = user.address.street,
            MailingPostalCode = user.address.zipcode );
            contacts.add(con);
        }
        insert contacts;
    }
}
