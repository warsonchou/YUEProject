root = exports ? @

Router.configure {
    layoutTemplate: 'layout'
    wait-on: ->
        Meteor.subscribe 'uploadAvatar'

}

Router.route '/', -> 
    Router.go '/index'

Router.route 'index/:activityLimit?', {
    name: 'index',
    wait-on: ->
        Session.set('is-login-register', true)
        activity-limit = parse-int(this.params.activity-limit) || 5
        find-options = {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: activity-limit}
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
    wait-on: ->
        Session.set('is-login-register', false)
        Session.set('is-login', true)
}

Router.route '/register', {
    name: 'register',
    wait-on: ->
        Session.set('is-login-register', false)
        Session.set('is-login', false)
        Meteor.subscribe 'userAccount'
}

Router.route '/createActivity', {
    name: 'createActivity',
    waitOn: ->
        return Meteor.subscribe 'Activity' and Meteor.subscribe 'uploadForActivity'
}

Router.route '/profile/:activityLimit?', {
    name : 'profile',
    wait-on: ->
        activity-limit = parse-int(this.params.activity-limit) || 6
        find-options = {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: activity-limit}
    data: ->
        more = (parse-int(this.params.activity-limit) || 6) is Activity.find-by-username("12330031").count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 6) + 6})
        return {
            activities: Activity.find-by-username "12330031"
            next-path: next
        }
}
 
Router.route '/changeProfile', {
    name: 'changeProfile',
    wait-on: ->
        user = User.find-user "12330031"
        Meteor.subscribe 'user', user
        Meteor.subscribe 'user', User.find-user "12330031"
        Meteor.subscribe 'uploadForActivity'
        Meteor.subscribe 'uploadAvatar'
    data: ->
        user = User.find-user "12330031"
        console.log user
        return {
            users: User.find-user "12330031"
        }
}

Router.route '/activity/:activityId', {
    name: 'activity'
    waitOn: ->
        Meteor.subscribe 'Activity'
        Meteor.subscribe 'uploadForActivity'
    data: ->
        Activity.find-by-id this.params.activityId
        # return Meteor.subscribe 'Activity'
}

require-login = !->
    if not Meteor.user-id()
        Router.go '/login'
    else
        this.next!

Router.on-before-action require-login, {only: 'createActivity', 'profile', 'homework-page'}
