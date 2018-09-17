@isTest
public class TestTaskController {

    @isTest static void getTaskHabit() { 
       String types = 'Habit';
       String status = '';
       Contact test =  TestDataFactory.createAssigment(5, types, false, status); 
       Integer items = TaskController.getItems(test.Id, types, status ).size(); 
       System.assertEquals(5, items);                                        
    }
    
    @isTest static void getTaskDailyCompleted() { 
       String types = 'Daily';
       String status = 'Completed';
       Contact test = TestDataFactory.createAssigment(5, types, false ,status); 
       Integer items = TaskController.getItems(test.Id, types, status ).size(); 
       System.assertEquals(5, items);                                        
    }
    
    @isTest static void getTaskDailyNotCompleted() { 
       String types = 'Daily';
       String status = 'New';
      Contact test = TestDataFactory.createAssigment(5, types, false, status); 
       Integer items = TaskController.getItems(test.Id, types, 'NotCompleted').size(); 
       System.assertEquals(5, items);                                        
    }
    
    @isTest static void getTaskDailyAll() { 
       String types = 'Daily';      
       Contact test = TestDataFactory.createAssigment(5, types, false, 'New');          
       Integer items = TaskController.getItems(test.Id, types, 'All').size(); 
       System.assertEquals(5, items);                                        
    }
    
    @isTest static void updateHabit() { 
       String types = 'Habit';      
       Contact cont = TestDataFactory.createAssigment(1, types, false, 'New'); 
       String idTask = [Select id from Assignment__c where Contact_Name__c =: cont.Id ].Id;  
       Decimal items = TaskController.updateHabit(idTask, 'Completed', true); 
       System.assertEquals(1, [select count() from Assignment__c where Condition__c =  'Completed' ]);                                        
    }
    
    @isTest static void updateDaily() { 
       String types = 'Daily';      
       Contact cont = TestDataFactory.createAssigment(1, types, false, 'New'); 
       String idTask = [Select id from Assignment__c where Contact_Name__c =: cont.Id ].Id;  
       Decimal items = TaskController.updateHabit(idTask, 'Completed', false); 
       System.assertEquals(1, [select count() from Assignment__c where Status__c =  'Completed' ]);                                        
    }
    
    @isTest static void pointsNowTest() { 
       String types = 'Habit';      
       Contact cont = TestDataFactory.createAssigment(1, types, false, 'New');
       String idTask = [Select id from Assignment__c where Contact_Name__c =: cont.Id ].Id; 
       TestDataFactory.UpdateStatus(cont, types);   
       Decimal ite = TaskController.pointsNow(idTask); 
       System.assertEquals(1, [select Total_Points__c from Contact Limit 1].Total_Points__c);                                        
    }

     @isTest(SeeAllData=true)
	   static void searchDBTest() {        
       String jsonResult = TaskController.searchDB('Contact','FirstName','Id',200,'FirstName','a');        
       TaskController.ResultWrapper emp = new TaskController.ResultWrapper('Contact', 'Name', '34');
       System.assert(jsonResult != null);
                                           
    }

 


}