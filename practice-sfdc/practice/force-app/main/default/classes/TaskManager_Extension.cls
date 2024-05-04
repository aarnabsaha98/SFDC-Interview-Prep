public with sharing class TaskManager_Extension extends TaskManager_DP{
    public String scheduledTime;
    public String assignedUser;
    private Integer reminderIncremental = 0;
 
    public TaskManager_Extension(  String name, String description, String scheduledTime, String assignedUser, Integer reminderIncremental) {
        super(name, description);
        
        this.scheduledTime = scheduledTime;
        this.assignedUser = assignedUser;
        this.reminderIncremental = reminderIncremental;
        System.debug('logLevel :  This task :' + this.name + 'is assigned to '+ this.assignedUser + ' at :' + scheduledTime);
    }

}