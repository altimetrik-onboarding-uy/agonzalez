trigger CalculatePoints on Assignment__c (after update) {     
  
   if(trigger.isUpdate)	{
    //Get all Assignment__c
    List<Assignment__c> listTask = [SELECT Id, name, Contact_Name__c,Status__c,EndDate__c,DailyDate__c,RecordTypeId,Points__c,LastModifiedDate
                                    from Assignment__c where Id IN :Trigger.newMap.keySet()];
    Set<Contact> listContact = new Set<Contact>();
    
       
    for (Assignment__c a :listTask) {	            
     String typeTask = [SELECT Name FROM RecordType WHERE SobjectType = 'Assignment__c' And Id =: a.RecordTypeId].Name;    
	   Contact contObject =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: a.Contact_Name__c Limit 1];
      
        if(typeTask == 'TO-DO'){            
            if(a.Status__c  == 'Completed' && a.LastModifiedDate.day() <= a.EndDate__c.day()){  
       		   contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;            
            }else{
                 contObject.Total_Points__c = contObject.Total_Points__c - a.Points__c;      
            } 
        }
        
          if(typeTask == 'Daily'){
           if(a.Status__c  == 'Completed' && a.LastModifiedDate.day() == a.DailyDate__c.day()){ 
                 contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;       		           
            }else{
                 contObject.Total_Points__c = contObject.Total_Points__c - a.Points__c;      
            } 
        }
        
        if(typeTask == 'Habit'){
            contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;
        }
        
        listContact.add(contObject);           
       }   
        list<Contact> toUpdate = new list<Contact>();
       	toUpdate.addAll(listContact);
        update toUpdate;   
    }    
}