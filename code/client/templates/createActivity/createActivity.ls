Template['createActivity'].events {
	'submit form': (e)->
		e.preventDefault!
		ActivityName = $(e.target).find('[name=ActivityName]').val()
		ActivityPlace = $(e.target).find('[name=ActivityPlace]').val()
		Deadeline = $(e.target).find('[name=ActivityDeadline]').val()
		files = $(e.target).find('[name=image]')[0].files
		open-or-not-information = false
		ActivityStartTime = $(e.target).find('[name=ActivityStartTime]').val()
		ActivityEndTime = $(e.target).find('[name=ActivityEndTime]').val()
		ActivityCategory = $(e.target).find('[name=ActivityCategory]').val()
		PeopleNumber = $(e.target).find('[name=PeopleNumber]').val()
		ActivityDescription = $(e.target).find('[name=ActivityDescription]').val()


		UploadForActivity.insert files, ActivityName, PeopleNumber, Deadeline, ActivityPlace, ActivityStartTime, ActivityEndTime, open-or-not-information, ActivityCategory, ActivityDescription
}


Template['createActivity'].helpers {
	images: ->
		UploadForActivity.findbyid "QyXbDKWegYppJgyab"
}

Template['createActivity'].onRendered !->
	$('.datetimepicker').datetimepicker!
	$('select.dropdown').dropdown!
	$('.ui.radio.checkbox').checkbox!