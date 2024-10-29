public virtual class TaskManager_DP extends TaskManager_Abstract{

    public String name;
    //public static String description = 'Arnab'; // Static field cannot be referenced from a non static context: 
    public String description;

    public TaskManager_DP() {
        // System.debug('logLevel :  TaskManager_DP Constructor');
    }

    public TaskManager_DP(String name, String description) {
        this.name = name;
        this.description = description;
        // System.debug('logLevel :  T name :' + this.name + ' description :' + this.description);

    }

    public void createTask(String name, String description) {
        System.debug('logLevel :  Task creating name :' + name + ' description :' + description);
    }
    public void updateTask(String name) {
        System.debug('logLevel :  Task updated +' + name);
    }
    public void deleteTask(String name) {
        System.debug('logLevel :  Task deleted' + name);
    }
    
}
