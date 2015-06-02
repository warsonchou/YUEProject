root = exports ? @

Router.configure {
    layoutTemplate: 'layout'
}

Router.route '/', -> 
    Router.go '/index'

Router.route 'index/:activityLimit?', {
    name: 'index',
    wait-on: ->
        activity-limit = parse-int(this.params.activity-limit) || 5
        find-options = {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'uploadAvatar'
    data: ->
        more = (parse-int(this.params.activity-limit) || 5) is Activity.all!.count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 5) + 5})
        return {
            activities: Activity.all!
            next-path: next
        }
}

Router.route 'type/:typename/:activityLimit?', {
    name: 'type',
    wait-on: ->
        activity-limit = parse-int(this.params.activity-limit) || 5
        find-options = {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'uploadAvatar'
    data: ->
        more = (parse-int(this.params.activity-limit) || 5) is Activity.all!.count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 5) + 5})
        return {
            activities: Activity.all!
            next-path: next
        }
}

Router.route '/login', {
    name: 'login',
}

Router.route '/register', ->
    this.render 'register', {}

Router.route '/createActivity', {
    name: 'createActivity',
    waitOn: ->
        return Meteor.subscribe 'activities' and Meteor.subscribe 'uploadForActivity'
}

Router.route '/profile', ->
    this.render 'profile', {}

Router.route '/activity/:activityId', {
    name: 'activity'
    waitOn: ->
        return Meteor.subscribe 'activities'
}

require-login = !->
    console.log 'hehe'
    if not Meteor.user-id()
        Router.go '/login'
    else
        this.next!

Router.on-before-action require-login, {only: 'createActivity', 'profile', 'homework-page'}