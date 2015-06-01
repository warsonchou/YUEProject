activities = Activity.all!

Template.index.helpers({
<<<<<<< HEAD
    activities: testData
    images: ->
        user = Meteor.user!
        profile = user.profile
        UploadAvatar.findbyid profile.avatarId
=======
    activities: activities
>>>>>>> eadade7fe09adc9b90566274c76b6c400d720070
})

Template.activityItem.helpers({
    sponsorname: 'wangnima'
})
