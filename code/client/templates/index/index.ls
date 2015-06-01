activities = Activity.all!

Template.index.helpers({
    activities: activities
})

Template.activityItem.helpers({
    sponsorname: 'wangnima'
})