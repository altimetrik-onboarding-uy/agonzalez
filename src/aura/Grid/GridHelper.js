({
	read: function (component, newItem) {
		var status = component.get("v.status");
		var typeTask = component.get("v.typeTask");
		// Create the action
		var action = component.get("c.getItems");
		action.setParams({
			"typeTask": typeTask,
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

	updatedStatus: function (component, event, status) {
		// Update
		var habit = component.get("v.buttonHabit");
		var id = event.getSource().get("v.value");
		var action = component.get("c.updateHabit");
		action.setParams({
			"id": id,
			"status": status,
			"habit": habit
		});
		// Add callback behavior for when response is received
		action.setCallback(this, function (response) {
			var state = response.getState();
			if (state === "SUCCESS") {
				this.read(component, event);
				if(status != 'In Progress'){
					document.getElementById("notifi").style.display = 'block'; 
				}
				setInterval(function(){document.getElementById("notifi").style.display = 'none'},4000);
				
			}
			else {
				console.log("Failed with state: " + state);
			}
		});

		// Send action off to be executed
		$A.enqueueAction(action);
	},

	 
})