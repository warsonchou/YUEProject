activities = Activity.all!

test-data = [{
        name: 'fuck',
        sponsor: 'Wangnima',
        numOfPeople: 100,
        activityTime: '2015-06-13',
        place: 'hotel',
        type: 'sex',
        cover: '/public/images/11.jpg'
},
{
        name: 'fuck',
        sponsor: 'Wangnima',
        numOfPeople: 100,
        activityTime: '2015-06-13',
        place: 'hotel',
        type: 'sex',
        cover: '/public/images/11.jpg'
}
]

Template.index.helpers({
    activities: testData
    images: ->
        user = Meteor.user!
        profile = user.profile
        UploadAvatar.findbyid profile.avatarId
})

Template.activityItem.helpers({
    sponsorname: 'wangnima'
})
