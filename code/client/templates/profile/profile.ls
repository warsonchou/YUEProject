activities = Activity.all!

test-data = [{
        name: '一起跑吧',
        sponsor: 'Wangqing',
        numOfPeople: 100,
        activityTime: '2015-06-13',
        place: '内环',
        type: 'sex',
        cover: '/public/images/11.jpg'
},
{
        name: '一起不跑',
        sponsor: '王青',
        numOfPeople: 100,
        activityTime: '2015-06-13',
        place: '中环',
        type: 'sex',
        cover: '/public/images/11.jpg'
}
]

Template.profile.helpers({
    activities: testData
})

Template.activityItem.helpers({
    sponsorname: 'wangnima'
})
