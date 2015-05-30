Template.register.events {
	"submit form": (e) ->
		e.prevent-default!

		username = $(e.target).find '[name=username]' .val!
		password = $(e.target).find '[name=password]' .val!

		profile = {
			nickname: $(e.target).find '[name=nickname]' .val!
			sex: $(e.target).find '[name=sex]' .val!
			tel: $(e.target).find '[name=tel]' .val!
			qq: $(e.target).find '[name=qq]' .val!
			mail: $(e.target).find '[name=mail]' .val!
		}

		User.register(username, password, profile, (error) ->
			if not error
				Router.go '/'
			)
}