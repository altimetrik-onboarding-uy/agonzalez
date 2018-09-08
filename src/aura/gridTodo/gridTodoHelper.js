({
	read: function (component, newItem) {
		var status = component.get("v.status");
        // Create the action
        var action = component.get("c.getItems");
		action.setParams({
			"typeTask": 'TO-DO',
			"status": status
		});	
        // Add callback behavior for when response is received
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.tasks", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });

        // Send action off to be executed
        $A.enqueueAction(action);
    },


    updatedStatus: function(component,event,status){
        // Update
        var id = event.getSource().get("v.value");
        var action = component.get("c.updateHabit");
        action.setParams({
            "id": id,
            "status": status,
            "habit": false
        });	
        // Add callback behavior for when response is received
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                this.read(component,event);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
       
        // Send action off to be executed
        $A.enqueueAction(action);
           }
})