Template.layout.helpers {
	userinformation: ->
		avatar = null
		if User.current-user!
			currentUser = User.current-user!
			avatar = UploadAvatar.findbyid currentUser.profile.avatarId
		
		return avatar
		
	currentUserNickName: ->
		currentUserNickName = User.current-user! .profile.nickname
		currentUserNickName

	/*userNickname: ->
		if User.current-user!
			currentUser = User.current-user!
			return currentUser.profile.nickname*/


	isLoginRegister: ->
		Session.get("is-login-register")

	isLogin: ->
		Session.get("is-login")

}


Template.layout.events {
	'click .logout-btn': !->
		User.logout!
		Router.go "/"

	'click .login-btn': !->
		Router.go "/login"

	"click .createActivity-btn": !->
		if User.current-user!
			Router.go "/createActivity"
		else
			Router.go "/login"

	"click .home-btn": !->
		Router.go "/"

	"click .profile-btn": !->
		Router.go "/profile"

	"click .changeProfile-btn": !->
		Router.go "/changeProfile"

}


