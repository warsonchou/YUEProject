Template.register.events {
	'change .avatar-input': (e)!->

		e.preventDefault!

		if typeof FileReader is undefined
			alert '抱歉，你的浏览器不支持预览功能'

		reader = new FileReader()
		file = e.target.files[0]
		reader.readAsDataURL file
		reader.onload = (e)!->
			$ '#cover' .attr 'src', reader.result

	"submit form": (e) ->
		e.prevent-default!

		username = $(e.target).find '[name=username]' .val!
		password = $(e.target).find '[name=password]' .val!
		avatar = $(e.target).find('[name=avatar]')[0].files

		$(".login-register").form {
			# tel: {
			# 	identifier : 'tel'
			# 	rules: [
			# 		{
			# 			type : 'is[/^[1][3-8]+\\d{9}/]'
			# 			prompt : 'Please enter the correct phone number'
			# 		}
			# 	]
			# }
			username: {
				identifier : 'username'
				rules: [
					{
						type : 'empty'
						prompt: 'Please enter your username'
					}
				]
			}
			password: {
				identifier : 'password'
				rules: [
					{
						type : 'empty'
						prompt: 'Please enter your password'
					}
					{
						type : 'length[6]'
						prompt: 'Your password must be at least 6 characters'
					}
				]
			}
			nickname: {
				identifier : 'nickname'
				rules: [
					{
						type : 'empty'
						prompt : 'Please enter your nickname'
					}
				]
			}
			#没有解决正则表达式如何去匹配
			tel: {
				identifier : 'tel'
				rules: [
					{
						type : 'length[6]'
						prompt : 'Please enter your phone number'
					}
				]
			}
			qq: {
				identifier : 'qq'
				rules: [
					{
						type : 'empty'
						prompt : 'Please enter your qq number'
					}
				]
			}
			mail: {
				identifier : 'mail'
				rules: [
					{
						type : 'email'
						prompt : 'Please enter a valid email address'
					}
				]
			}
		}

		$(".login-register .segment") .addClass "error"

		profile = {
			nickname: $(e.target).find '[name=nickname]' .val!
			sex: $(e.target).find '[name=sex]' .val!
			tel: $(e.target).find '[name=tel]' .val!
			qq: $(e.target).find '[name=qq]' .val!
			mail: $(e.target).find '[name=mail]' .val!
			avatarId: null
		}
		# is-found = User.find-username username
		# if is-found
		# 	Session.set("register-username-error": "用户名已存在")
		# 	return

		User.register(username, password, profile, (error) ->
			if not error
				UploadAvatar.insert avatar
				Router.go '/'
			)
}


Template.register.helpers {
	registerUsernameError: ->
		Session.get "register-username-error"
}