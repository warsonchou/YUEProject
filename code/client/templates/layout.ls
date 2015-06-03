Template.layout.helpers {
	userinformation: ->
		avatar = null
		if User.current-user!
			currentUser = User.current-user!
			avatar = UploadAvatar.findbyid currentUser.profile.avatarId
		
		return avatar


	isLoginRegister: ->
		Session.get("is-login-register")

	isLogin: ->
		Session.get("is-login")

}


Template.layout.events {
	'click .logout': !->
		User.logout!
		Router.go "/"

	'click .login-btn': !->
		$('#layoutMain') .empty()
		Router.go "/login"
}


