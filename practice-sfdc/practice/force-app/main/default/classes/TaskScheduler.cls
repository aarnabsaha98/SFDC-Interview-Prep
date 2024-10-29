public with sharing class TaskScheduler implements TaskManager_Interface{


    public void scheduleTask() {

    TaskManager_DP tManager = new TaskManager_DP('Drink Water' , 'Drinking water is healthy');
    tManager.createTask();
    // tManager.updateTask('Drink Wine');
    // tManager.deleteTask('Drink Wine');

    // Static field cannot be referenced from a non static context:  System.debug(tManager.createdUser);

    // Static method cannot be referenced from a non static context:   tManager.assignTask();

    System.debug('logLevel TaskManager_Extension Starts');
    TaskManager_DP tManager_1 = new TaskManager_Extension('Drink Water' 
    , 'Drinking water is healthy'
    , 'In the morning!!'
    , 'Arnab Saha'
    , 0); // Inheritance // Polymorphism
    tManager_1.createTask();
    // tManager_1.updateTask('Drink Water');
    // tManager_1.deleteTask('Drink Water');

    

    }
    public void setTaskReminder(){
        System.debug('logLevel :'+ '1PM' + 'assignedUser :' + 'Arnab');
    }
    public void assignTask(String assignedUser){
        System.debug('logLevel :' + 'assignedUser :' + 'Anrba');
    }
}