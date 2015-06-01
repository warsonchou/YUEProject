activities = Activity.all!

Template.index.helpers({
    images: ->
        user = Meteor.user!
        profile = user.profile
        avatar = UploadAvatar.findbyid profile.avatarId
        avatar
    activities: activities
})

Template.activityItem.helpers({
    sponsorname: 'wangnima'
})
