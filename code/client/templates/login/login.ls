Template.login.events {
	"submit form": (e) ->
		e.prevent-default!
		username = $(e.target).find '[name=username]' .val!
		password = $(e.target).find '[name=password]' .val!

		User.login(username, password, (error) ->
			if not error
				Router.go '/'
			)

	"click .login-register-btn": !->
		Session.set('is-login', false)
		Router.go '/register'
}
