public with sharing class TaskController {
    
       @TestVisible class ResultWrapper{
         String objName;
         String text;
         String val;
           
            @TestVisible ResultWrapper(String obj, String texto, String value) {
            objName = obj;
            text = texto;
            val = value;
        }
    }   

    @AuraEnabled
    public static List<Assignment__c> getItems (String id, String typeTask, String status) {
        List<Assignment__c> listHabit = new List<Assignment__c>();
        List<Assignment__c> listDone = new List<Assignment__c>();
        List<Assignment__c> listNotDone = new List<Assignment__c>();
       
       for(Assignment__c task: [SELECT Id, Name, RecordTypeId, Status__c  FROM Assignment__c WHERE Contact_Name__c =: id]){
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
    public static Decimal updateStatus(String id, String status, Boolean habit) {
      
        Assignment__c item = [SELECT Id, Name, Condition__c,Status__c,Points__c,Contact_Name__c  
         FROM Assignment__c Where Id =: id];        
          
        Decimal totalPointBeforeUpdate =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: item.Contact_Name__c Limit 1].Total_Points__c;
        
        // Perform isUpdatable() checking first, then
        if(habit){
             item.Condition__c = status;
        }else{
            item.Status__c = status;
        }       
        upsert item;
        return totalPointBeforeUpdate;
    }

    @AuraEnabled
    public static Decimal pointsNow(String id) {
        Assignment__c item = [SELECT Id, Name, Condition__c,Status__c,Points__c,Contact_Name__c  
         FROM Assignment__c Where Id =: id]; 
			 
        Decimal totalPoint =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: item.Contact_Name__c Limit 1].Total_Points__c;
           
        return totalPoint;
    }

    /**
     * Returns JSON of list of Pais
     * @objectName - Name of SObject
     * @fld_API_Text - API name of field to display to user while searching 
     * @fld_API_Val - API name of field to be returned by Lookup Component
     * @lim   - Total number of record to be returned
     * @fld_API_Search - API name of field to be searched
     * @searchText - text to be searched
     * */
    @AuraEnabled 
    public static String searchDB(String objectName, String fld_API_Text, String fld_API_Val, 
                                  Integer lim,String fld_API_Search,String searchText ){
        
        searchText='\'%' + String.escapeSingleQuotes(searchText.trim()) + '%\'';

        
        String query = 'SELECT '+fld_API_Text+' ,'+fld_API_Val+
            			' FROM '+objectName+
            				' WHERE '+fld_API_Search+' LIKE '+searchText+ 
            			' LIMIT '+lim;
       
        List<sObject> sobjList = Database.query(query);
        List<ResultWrapper> lstRet = new List<ResultWrapper>();
        
        for(SObject s : sobjList){
            String texto = String.valueOf(s.get(fld_API_Text));
            String value = String.valueOf(s.get(fld_API_Val));
            ResultWrapper obj = new ResultWrapper( objectName, texto, value);
            lstRet.add(obj);
        } 
         return JSON.serialize(lstRet) ;
    }
   
     
 
}