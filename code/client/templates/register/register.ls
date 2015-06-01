Template.register.events {
	"submit form": (e) ->
		e.prevent-default!

		username = $(e.target).find '[name=username]' .val!
		password = $(e.target).find '[name=password]' .val!
		avatar = $(e.target).find('[name=avatar]')[0].files

		profile = {
			nickname: $(e.target).find '[name=nickname]' .val!
			sex: $(e.target).find '[name=sex]' .val!
			tel: $(e.target).find '[name=tel]' .val!
			qq: $(e.target).find '[name=qq]' .val!
			mail: $(e.target).find '[name=mail]' .val!
			avatarId: null
		}


		User.register(username, password, profile, (error) ->
			if not error
				UploadAvatar.insert avatar
				Router.go '/'
			)
}
