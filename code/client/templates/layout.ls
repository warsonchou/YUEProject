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
		Router.go "/login"

	"click .createActivityButton": !->
		if User.current-user!
			Router.go "/createActivity"
		else
			Router.go "/login"

	"click .go-to-main-page": !->
		Router.go "/"
}


