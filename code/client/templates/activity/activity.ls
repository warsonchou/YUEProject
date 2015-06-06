Template.activity.helpers {
	activity : ->
		Activity.find-by-id Session.get "activityId"
	is-agree : ->
		Activity.find-by-id Session.get "activityId" .open-or-not
	is-sponsor: ->
		Meteor.user! .username == Activity.find-by-id Session.get "activityId" .sponsor
	sponsor-phone: ->
		User.find-user (Activity.find-by-id Session.get "activityId" .sponsor) .profile.tel
	username: ->
		Activity.find-by-id Session.get "activityId" .applyList
}

Template.activity.events {
	"click .apply" : !->
		console.log(Session.get("activityId"), Meteor.user()._id)
		result = Activity.add-application (Session.get "activityId"), (Meteor.user! ._id), 2, (Meteor.user! .profile.tel)
		alert(result)
	"click .select" : (event)!->
		parent = event.target.parentNode
		console.log(this)
		if (parent.class-list.contains("checked"))
			for id,i in Activity.temporary-container
				if id is this.applier then Activity.temporary-container.splice(i, 1); break
			parent.class-list.remove("checked")
		else
			Activity.temporary-container.push this.applier
			parent.class-list.add("checked")
	"click .ensure-select" : (event)!->
		activity-id = Session.get "activityId"
		for id in Activity.temporary-container
			console.log(activity-id, id)
			Activity.choose-participator(activity-id, id)
		while Activity.temporary-container.length is not 0
			Activity.temporary-container.pop!
}

