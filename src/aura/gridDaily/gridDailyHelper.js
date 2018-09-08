({
	read: function (component, newItem) {
		var status = component.get("v.status");
        // Create the action
        var action = component.get("c.getItems");
		action.setParams({
			"typeTask": 'Daily',
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
})