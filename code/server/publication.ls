Meteor.publish 'activities', (options) ->
	if not options
		check options, {
			sort: Object,
			limit: Number
		}
	console.log(Activity.collection.find({}, options))
	return Activity.collection.find {}, options


# here people related the images should add some logic here
Meteor.publish 'uploadAvatar' ->
	return UploadAvatar.find!

# publish the uploaded images for activity
Meteor.publish 'uploadForActivity' ->
	return UploadForActivity.find!

Meteor.publish 'activityForComment', (activityId)->
	return Activity.find-by-id activityId
