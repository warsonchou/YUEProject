Template.commentoritem.helpers ({
	headphoto: ->
		id = User.find-user(this.applier-name).profile.avatarId
		avatar = UploadAvatar.findbyid id
		return avatar
	has-headphoto: ->
		id = User.find-user(this.applier-name).profile.avatarId
		return id !== null
})
