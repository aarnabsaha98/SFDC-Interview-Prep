public with sharing class TaskScheduler implements TaskManager_Interface{


    public void scheduleTask() {


    TaskManager_DP tManager = new TaskManager_DP('Drink Water' , 'Drinking water is healthy');


    tManager.createTask();
    tManager.updateTask('Drink Wine');
    tManager.deleteTask('Drink Wine');

    // Static field cannot be referenced from a non static context:  System.debug(tManager.createdUser);

    // Static method cannot be referenced from a non static context:   tManager.assignTask();

    TaskManager_DP tManager_1 = new TaskManager_Extension('Drink Water' 
    , 'Drinking water is healthy'
    , 'In the morning!!'
    , 'Arnab Saha'
    , 0); // Inheritance // Polymorphism
    tManager_1.createTask();
    tManager_1.updateTask('Drink Wine');
    tManager_1.deleteTask('Drink Wine');

    }
    public void setTaskReminder() { // Renamed method
        
        System.debug('logLevel : testTaskReminder');
    }

    public static void assignTask(String assignedUser) {
        System.debug('logLevel : TestTask assigned');
    }

}