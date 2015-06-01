Meteor.publish 'activities', (options)->
	if not options
		check options, {
			sort: Object,
			limit: Number
		}

	return Activity.collection.find {}, options


# here people related the images should add some logic here
Meteor.publish 'uploadAvatar' ->
	return UploadAvatar.find!

# publish the uploaded images for activity
Meteor.publish 'uploadForActivity' ->
	return UploadForActivity.find!