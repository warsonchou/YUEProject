Template.activityItem.helpers ({
	images: ->
		cover = this.cover
		console.log cover
		return UploadForActivity.findbyid cover
	sponsor-images: ->
		sponsor = User.find-user this.sponsor
		return UploadAvatar.findbyid sponsor.profile.avatarId
	typename: ->
		typelist = ["餐饮", "运动", "学习", "电影", "逛街", "开黑", "其他"]
		return typelist[parse-int(this.type) - 1]
})
