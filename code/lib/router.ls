root = exports ? @

get-local-time = (time)->
        time-string = time.get-full-year! + '/'
        time-string += '0' if (time.get-month! + 1) < 10
        time-string += (time.get-month! + 1) + '/'
        time-string += '0' if time.get-date! < 10
        time-string += time.get-date! + ' '
        time-string += '0' if time.get-hours! < 10
        time-string += time.get-hours! + ':'
        time-string += '0' if time.get-minutes! < 10
        time-string += time.get-minutes!
        return time-string

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
        find-options = {sort: {starting-time: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'uploadForActivity'
    data: ->
        more = (parse-int(this.params.activity-limit) || 5) is Activity.all!.count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 5) + 5})
        now-time = new Date!
        now-time = get-local-time now-time
        return {
            activities: Activity.collection.find {deadline: {$gt: now-time}}
            next-path: next
        }
}

Router.route 'type/:typename/:activityLimit?', {
    name: 'type',
    wait-on: ->
        Session.set('is-login-register', true)
        activity-limit = parse-int(this.params.activity-limit) || 5
        find-options = {sort: {starting-time: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'uploadForActivity'
    data: ->
        more = (parse-int(this.params.activity-limit) || 5) is Activity.all!.count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 5) + 5})
        now-time = new Date!
        now-time = get-local-time now-time
        return {
            activities: Activity.collection.find {deadline: {$gt: now-time}, type: this.params.typename}
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
    name: 'activity',
    waitOn: ->
        Meteor.subscribe 'Activity'
        Meteor.subscribe 'uploadForActivity'
        Meteor.subscribe 'userAccount'
        Session.set "activityId", this.params.activityId
}

require-login = !->
    if not Meteor.user-id()
        Router.go '/login'
    else
        this.next!

Router.on-before-action require-login, {only: 'createActivity', 'profile'}
