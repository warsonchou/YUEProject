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
		Activity.add-application (Session.get "activityId"), (Meteor.user! ._id), 2, (Meteor.user! .profile.tel)
}

