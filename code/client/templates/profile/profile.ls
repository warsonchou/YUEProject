Template.profile.helpers {
	images: ->
		Activity.find-by-username-has-not-participated "uuu"
}