Template.activityItem.helpers ({
	images: ->
		cover = this.cover
		return UploadForActivity.findbyid cover
	sponsor-images: ->
		sponsor = User.find-user this.sponsor
		return UploadAvatar.findbyid sponsor.profile.avatarId
	typename: ->
		typelist = ["运动", "学习", "聚餐", "其它"]
		return typelist[parse-int(this.type) - 1]
})