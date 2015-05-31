Meteor.publish 'activities', (options)->
	if not options
		check options, {
			sort: Object,
			limit: Number
		}

	return Activity.collection.find {}, options
