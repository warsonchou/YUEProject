Template.layout.helpers {
	userinformation: ->
		avatar = null
		if User.current-user!
			currentUser = User.current-user!
			avatar = UploadAvatar.findbyid currentUser.profile.avatarId
		
		return avatar
}


Template.layout.events {
	'click .logout': !->
		User.logout!
		Router.go "/"
}


