Template.index.helpers({
    images: ->
        user = Meteor.user!
        profile = user.profile
        avatar = UploadAvatar.findbyid profile.avatarId
        avatar
})

Template.activityItem.helpers({
    sponsorname: 'wangnima'
   
})
