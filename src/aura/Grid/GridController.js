({
    //Read
    doInit: function (component, event, helper) {
        helper.read(component, event);
    },


    //In Progress
    failed: function (component, event, helper) {
        helper.updatedStatus(component, event, 'In Progress');
    },

    //Completed
    completed: function (component, event, helper) {
        helper.updatedStatus(component, event, 'Completed');
    },

    //Failed
    failedHabit: function (component, event, helper) {
        helper.updatedStatus(component, event, 'Failed');
    },

    ShowNotification: function (cmp, event, helper) {
       
        var notification = event.getSource();

        //Create component dynamically
       
            $A.createComponent(
                "c:Notification", {
                    "before": 0,
                    "now": 0
                }, function (contentComponent, status, error) {
                  
                    if (status === "SUCCESS") {

                       
                        var body = cmp.get("v.body");
                     
                        body.push(contentComponent);
                       
                        cmp.set("v.body", body);
                      
                      
    
                    } else {
                        throw new Error(error);
                    }  
                   
                }
            );
       
      


    },

})