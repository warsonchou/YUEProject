root = exports ? @

root.UploadAvatar = {
	collection: new FS.Collection("uploadAvatar", {
		stores: [new FS.Store.FileSystem("uploadAvatar")]
		filter:
			maxSize: 5122880 #5m
			allow:
				contentTypes: ['image/*']
				extensions: ['png', 'jpg', 'jpeg', 'bmp']
			onInvalid: (message)!->
				if Meteor.isClient
					alert message
				else
					console.log message
		})

	insert: (username, avatar)->
		for file in files
			return this.collection.insert file, (err, fileObj)!->
				if err
					console.log 'insert picture error'
				else
				# to do list for FBI, you should modify the user profile to remember the avatar id, and you can refer to user.ls and upload.ls
					i = 0
					#user = this.current-user!
					# fileObj._id

	find: ->
		this.collection.find!
	#you should careful about here, because the CollectionFS does not offer the findone,
	#so i use find which return an array when you use findbyid, so that you iterate the result
	#such as
	#				each images			(the array result that returned by the findbyid)
	#						img(src="{{this.url}}")
	findbyid: (avatarId)->
		this.collection.find {"_id": avatarId}


}