
Meteor.publish 'activities', (options)->
	if not options
		check options, {
			sort: Object,
			limit: Number
		}

	return Activity.collection.find {}, options


Meteor.publish 'Activity', ->
	return Activity.collection.find {}

# here people related the images should add some logic here
Meteor.publish 'uploadAvatar', ->
	return UploadAvatar.find!

# publish the uploaded images for activity
Meteor.publish 'uploadForActivity', ->
	return UploadForActivity.find!

Meteor.publish 'activityForComment', (activityId)->
	return Activity.find-by-id activityId


#publish user account 
Meteor.publish 'userAccount', ->
	return Meteor.users.find!

#publish acvitity for special user
Meteor.publish 'acvitityForProfile', (options)->
	if options
		otherOptions = {}
		otherOptions.sort = options.sort
		otherOptions.limit = options.limit
		check otherOptions, {
			sort: Object,
			limit: Number
		}
	console.log options.userinfo
	return Activity.collection.find {
		"sponsor": options.userinfo.username
	}, otherOptions


Meteor.publish 'acvitityForprofileParticipated', (optionsInparticipate)->
	if optionsInparticipate
		otherOptionsInparticipate = {}
		otherOptionsInparticipate.sort = optionsInparticipate.sort
		otherOptionsInparticipate.limit = optionsInparticipate.limit
		check otherOptionsInparticipate, {
			sort: Object,
			limit: Number
		}
	console.log optionsInparticipate.userinfo
	return Activity.collection.find {
		"applyList.applierName": optionsInparticipate.userinfo.username
	}, otherOptionsInparticipate




