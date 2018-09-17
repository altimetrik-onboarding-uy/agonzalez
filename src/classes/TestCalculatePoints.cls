@isTest
public class TestCalculatePoints {

     static String status = 'New';  
    
      @isTest static void TestAssigmentHabit() {
        String habit = 'Habit';       
        Contact contactTest = TestDataFactory.createAssigment(2, habit, false, status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, habit);
        Test.stopTest();
       
        // after the testing stops, assert records were updated properly
         System.assertEquals(2, [select Total_Points__c from Contact where Id =: contactTest.Id Limit 1].Total_Points__c);
        
    }
    
      @isTest static void TestAssigmentTodoCompleted() {
        String todo = 'TO-DO';    
        Contact contactTest = TestDataFactory.createAssigment(2, todo, false,status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
        // after the testing stops, assert records were updated properly
         System.assertEquals(4, [select Total_Points__c from Contact where Id =: contactTest.Id Limit 1].Total_Points__c);
        
    }
    
      @isTest static void TestAssigmentTodoFailed() {
        String todo = 'TO-DO';     
        Contact contactTest = TestDataFactory.createAssigment(2, todo,true,status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
        // after the testing stops, assert records were updated properly
         System.assertEquals(-4, [select Total_Points__c from Contact where Id =: contactTest.Id Limit 1].Total_Points__c);
        
    }
    
      @isTest static void TestAssigmentDailyCompleted() {
        String todo = 'Daily';
        Contact contactTest = TestDataFactory.createAssigment(2, todo, false,status); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
        // after the testing stops, assert records were updated properly
         System.assertEquals(2, [select Total_Points__c from Contact where Id =: contactTest.Id Limit 1].Total_Points__c);
        
    }
    
      @isTest static void TestAssigmentDailyFailed() {
        String todo = 'Daily';
        Contact contactTest = TestDataFactory.createAssigment(2, todo, true,status ); 
       
        Test.startTest();
        TestDataFactory.UpdateStatus(contactTest, todo);
        Test.stopTest();
       
        // after the testing stops, assert records were updated properly
         System.assertEquals(-2, [select Total_Points__c from Contact where Id =: contactTest.Id Limit 1].Total_Points__c);
        
    }
}