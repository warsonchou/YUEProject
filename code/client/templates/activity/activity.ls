Template.activity.helpers {
	activity : ->
		Activity.find-by-id Session.get "activityId"
	is-agree : ->
		Activity.find-by-id Session.get "activityId" .open-or-not
	is-sponsor: ->
		Meteor.user! .username == Activity.find-by-id Session.get "activityId" .sponsor
	sponsor-phone: ->
		User.find-user (Activity.find-by-id Session.get "activityId" .sponsor) .profile.tel
	username: ->
		Activity.find-by-id Session.get "activityId" .applyList
	is-sponsor-or-participant: ->
		return true if Meteor.user! .username == Activity.find-by-id Session.get "activityId" .sponsor
		for participant in Activity.find-by-id Session.get "activityId" .applyList
			if participant.applier is Meteor.user!._id
				return participant.success
		false
	images: ->
		image-id = Activity.find-by-id Session.get "activityId" .cover
		console.log image-id
		UploadForActivity.findbyid image-id

	commentors: ->
		all-participators = Activity.get-participate-applications Session.get "activityId"
		commentor = []
		for participator in all-participators
			if participator.comment isnt ''
				commentor.push participator
		return commentor
	none-comment: ->
		all-participators = Activity.get-participate-applications Session.get "activityId"
		commentor = []
		for participator in all-participators
			if participator.comment isnt ''
				commentor.push participator
		return commentor.length === 0
	is-participant-success: ->
		return false if Meteor.user! .username == Activity.find-by-id Session.get "activityId" .sponsor
		for participant in Activity.find-by-id Session.get "activityId" .applyList
			if participant.applier is Meteor.user!._id
				return participant.success
		false
	is-commented: ->
		return false if Meteor.user! .username == Activity.find-by-id Session.get "activityId" .sponsor
		for participant in Activity.find-by-id Session.get "activityId" .applyList
			if  participant.applier is Meteor.user!._id and participant.comment isnt ''
				return true
		false 
}

Template.activity.events {
	"click .apply" : !->
		console.log(Session.get("activityId"), Meteor.user()._id)
		result = Activity.add-application (Session.get "activityId"), (Meteor.user! ._id), 2, (Meteor.user! .profile.tel)
		alert(result)
	"click .select" : (event)!->
		if Meteor.user! .username == Activity.find-by-id Session.get "activityId" .sponsor
			parent = event.target.parentNode
			console.log(this)
			if (parent.class-list.contains("checked"))
				for id,i in Activity.temporary-container
					if id is this.applier then Activity.temporary-container.splice(i, 1); break
				parent.class-list.remove("checked")
			else
				Activity.temporary-container.push this.applier
				parent.class-list.add("checked")
	"click .ensure-select" : (event)!->
		activity-id = Session.get "activityId"
		for id in Activity.temporary-container
			console.log(activity-id, id)
			Activity.choose-participator(activity-id, id, true)
		while Activity.temporary-container.length is not 0
			Activity.temporary-container.pop!
	"click .cancel_select": (event)!->
		Activity.choose-participator(Session.get("activityId"), this.applier, false)

	"click .modify": ->
		Router.go('/modifyActivity/' + Session.get("activityId"))

	"submit form" : (e) !->
		e.prevent-default!
		comment = $(e.target).find '[name=comment]' .val!
		if comment === ''
			alert '你的评论还没有写哦！'
		else
			Activity.commentActivity Session.get("activityId") , Meteor.user-id! ,comment
}

/*
#test data
data = {
	name: 'Go dating',
	sponsor: 'wangqing',
	num-of-people: 4,
	starting-time: '2015/6/09',
	ending-time: '2015/6/10',
	deadline: '2015/6/09',
	place: 'gogo',
	open-or-not: true,
	type: 'yue',
	cover: 'image/1.jpg',
	applyList: [{
				applier : 0,
				applier-name: 'Amy',
				success: true,
				score-of-participator: 0,
				comment: '',
				score-of-sponsor: 0,
				createAt: new Date(),
				credit: 0,
				phone: 18903457891
				},
		{
			applier : 1,
			applier-name: 'Jack',
			success: true,
			score-of-participator: 0,
			comment: '',
			score-of-sponsor: 0,
			createAt: new Date(),
			credit: 0,
			phone: 18903459876
		}, 
		{
			applier : 2,
			applier-name: 'Angelababy',
			success: true,
			score-of-participator: 0,
			comment: 'falling in love!!!!',
			score-of-sponsor: 0,
			createAt: new Date(),
			credit: 0,
			phone: 18903451100
		}, 
		{
			applier : 3,
			applier-name: 'xiaoming',
			success: true,
			score-of-participator: 0,
			comment: 'Nice to meet Angelababy$$$',
			score-of-sponsor: 0,
			createAt: new Date(),
			credit: 0,
			phone: 18903450987
		}],
	description: 'yue'
}

<<<<<<< HEAD
Activity.collection.insert data
*/
=======
Template.activity.onRendered !->
	current-date = new Date!
	if current-date > new Date (Activity.find-by-id Session.get "activityId" .startingTime)
		console.log 'hi'
		$ '.modify' .attr 'disabled', 'disabled'
>>>>>>> d194740507b3697bedb06e756727f3add283c55a
