public with sharing class User_Wrapper {

    public Integer Id;
    public String name;
    public String email;
    public String phone;
    public String website;
    public Company company;
    public Address address;

    public Class Company{
        public String name;
    }
    public Class Address{
        public String street;
        public String suite;
        public String city;
        public String zipcode;
    }

    public static List<User_Wrapper> parse(String json){
        return (List<User_Wrapper>) System.JSON.deserialize(json, List<User_Wrapper>.class);
    }
}