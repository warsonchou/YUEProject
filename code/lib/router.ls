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
        Session.set('is-login-register', true)
        activity-limit = parse-int(this.params.activity-limit) || 6
        find-options = {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'activities', find-options
        Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: activity-limit}
        Meteor.subscribe 'uploadForActivity'
    data: ->
        name = User.current-user!
        more = (parse-int(this.params.activity-limit) || 6) is Activity.find-by-username-as-sponor(name.username).count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 6) + 6})
        
        return {
            activities: Activity.find-by-username-as-sponor(name.username)
            next-path: next
        }
}

Router.route '/profileParticipated/:activityLimit?', {
    name : 'profileParticipated',
    wait-on: ->
        Session.set('is-login-register', true)
        Meteor.subscribe 'activities'
        Meteor.subscribe 'uploadForActivity'
    data: ->
        name = User.current-user!
        more = (parse-int(this.params.activity-limit) || 6) is Activity.find-by-username(name.username).count!
        console.log "参与成功："+Activity.find-by-username-has-participated(name.username).count!
        console.log "未参与成功："+Activity.find-by-username-has-not-participated(name.username).count!
        console.log "参与成功和未参与成功："+Activity.find-by-username(name.username).count!
        next = null
        if more
            next = this.route.path({activity-limit: (parse-int(this.params.activity-limit) || 6) + 6})
        return {
            activities: Activity.find-by-username(name.username)
            next-path: next
        }
}

Router.route '/changeProfile', {
    name: 'changeProfile',
    wait-on: ->
        Meteor.subscribe 'user'
        Meteor.subscribe 'uploadForActivity'
        Meteor.subscribe 'uploadAvatar'
    data: ->
        user = User.current-user!
        avatar = null
        if user
            avatar = UploadAvatar.findbyid user.profile.avatarId
        return {
            profile: user.profile,
            avatar: avatar
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

Router.route '/modifyActivity/:activityId', {
    name: 'modifyActivity',
    wait-on: ->
        return Meteor.subscribe 'Activity' and Meteor.subscribe 'uploadForActivity'
        Session.set "activityId", this.params.activityId
}

require-login = !->
    if not Meteor.user-id()
        Router.go '/login'
    else
        this.next!

Router.on-before-action require-login, {only: 'createActivity', 'profile'}
