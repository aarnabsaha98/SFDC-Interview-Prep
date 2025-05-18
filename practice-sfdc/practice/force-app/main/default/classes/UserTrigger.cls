 
    
//Whenever user created and updated,  if its profile as platform user then add in 'Test_Group' public group.


trigger Usertrigger on User(after insert, after update)

{
    ID platformProfileID = [SELECT Id Profile WHere DeveloperName = 'platform user'].Id;

    List<Id> getUserList = new List<Id>();

    for(user us: Trigger.new){

        if(us.ProfileId == platformProfileID){

            getUserList.add(us.Id);

        }
    }

    Id groupId = [SELECT ID, DeveloperName FROM GROUP WHERE DeveloperName = 'Test_Group'].Id;

    List<GroupMember> gmList = new List<GroupMember>();

    for(Id ui :getUserList){
        GroupMember gm = new GroupMember();
        gm.userId = ui.Id;
        gm.groupId = groupId;
        gmList.add(gm);
    }
    insert gmList;
        

}