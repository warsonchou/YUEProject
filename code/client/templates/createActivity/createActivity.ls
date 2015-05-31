Template['createActivity'].events {
	'submit form': (e)->
		e.preventDefault!
		ActivityName = $(e.target).find('[name=ActivityName]').val()
		PeopleNumber = $(e.target).find('[name=PeopleNumber]').val()
		ActivityPlace = $(e.target).find('[name=ActivityPlace]').val()
		Deadeline = $(e.target).find('[name=Deadeline]').val()
		files = $(e.target).find('[name=image]')[0].files

		UploadForActivity.insert files, ActivityName, PeopleNumber, Deadeline, ActivityPlace
}


Template['createActivity'].helpers {
	images: ->
		UploadForActivity.findbyid "QyXbDKWegYppJgyab"
}