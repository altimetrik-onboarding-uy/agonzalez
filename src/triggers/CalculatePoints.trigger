trigger CalculatePoints on Assignment__c (after update) {
     
    for (Assignment__c a :Trigger.new) {	
            
     String typeTask = [SELECT DeveloperName,Id,Name,SobjectType FROM RecordType WHERE SobjectType = 'Assignment__c' And Id =: a.RecordTypeId].Name; 
   
	 Contact contObject =  [Select Id,Name,Total_Points__c from Contact WHERE Id =: a.Contact_Name__c Limit 1];
   
    switch on typeTask {
   		 when 'TO_DO' {	
       		//TO-DO   
       		 if(a.Status__c  == 'Completed' && a.LastModifiedDate < a.EndDate__c){         
       		   contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;            
       		 } 
        
        	if(a.Status__c  == 'Completed' && a.LastModifiedDate > a.EndDate__c){              
       		  contObject.Total_Points__c = contObject.Total_Points__c - a.Points__c;          
       		 }         
   
    }	
    	when 'Daily' {	
        	 //Daily  
        	 if(a.Status__c  == 'Completed' && a.LastModifiedDate.day() >= a.CreatedDate.addDays(1).day()){
                contObject.Total_Points__c = contObject.Total_Points__c - a.Points__c; 
      	 	 } 
        
       		 if(a.Status__c  == 'Completed' && a.LastModifiedDate.day() < a.CreatedDate.addDays(1).day()){ 
                 contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;
       		 }         
       
    }    
    	when else {		  
         	//Habit         	     
			contObject.Total_Points__c = contObject.Total_Points__c + a.Points__c;
      }
    }
         upsert contObject;   
  }

}