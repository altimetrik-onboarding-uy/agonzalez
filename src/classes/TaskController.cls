public class TaskController {

    @AuraEnabled
    public static List<Assignment__c> getItems (String typeTask, String status) {
        List<Assignment__c> listHabit = new List<Assignment__c>();
        List<Assignment__c> listDone = new List<Assignment__c>();
        List<Assignment__c> listNotDone = new List<Assignment__c>();
       
       for(Assignment__c task: [SELECT Id, Name, RecordTypeId, Status__c  FROM Assignment__c]){
                String type = [SELECT Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Assignment__c' And Id =: task.RecordTypeId].Name; 
                             
                //Done 
                if(type == typeTask && task.Status__c == 'Completed' ) {
                    listDone.add(task);
                }
                //NotDone 
                 if(type == typeTask && task.Status__c != 'Completed') {
                    listNotDone.add(task);
                } 
                //All Habit              
                  if(type == typeTask){
                    
                    listHabit.add(task);
                } 
             }

             if(status == 'Completed'){
               return listDone;
             }
             if(status == 'NotCompleted'){
               return listNotDone;
             }
             if(status == 'All'){
              listNotDone.addAll(listDone);
        	  return listNotDone ;
             }
           return listHabit;       		
    }
    


  @AuraEnabled
    public static Decimal updateHabit(String id, String status, Boolean habit) {
       
        Assignment__c item = [SELECT Id, Name, Condition__c,Status__c,Points__c,Contact_Name__c  
         FROM Assignment__c Where Id =: id]; 
          Decimal totalPoint =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: item.Contact_Name__c Limit 1].Total_Points__c;
      
        // Perform isUpdatable() checking first, then
        if(habit){
             item.Condition__c = status;
        }else{
            item.Status__c = status;
        }
       
        upsert item;
        return totalPoint;
    }

  @AuraEnabled
    public static Decimal pointsNow(String id) {
        Assignment__c item = [SELECT Id, Name, Condition__c,Status__c,Points__c,Contact_Name__c  
         FROM Assignment__c Where Id =: id]; 

        Decimal totalPoint =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: item.Contact_Name__c Limit 1].Total_Points__c;
            
        return totalPoint;
    }
 
}