root = exports ? @

root.UploadForActivity = {
	collection: new Mongo.Collection('uploadForActivity', {
		stores: [new FS.Store.FileSystem("images", {path: "~/uploads/activity"})],
		filter:
			maxSize: 1048576
			allow:
				contentTypes: ['image/*']
				extensions: ['png', 'jpg', 'jpeg', 'bmp']
			onInvalid: (message)!->
				if Meteor.isClient
					alert message
				else
					console.log message
		})
	insert: (files)->
		for file in files
			return uploadForActivity.insert(file)
}