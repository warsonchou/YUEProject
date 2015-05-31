Router.configure {
    layoutTemplate: 'layout'
}


Router.route '/:activityLimit?', {
    name: 'index',
    waitOn: ->
        limit = parse-int this.params.activity-limit
        return Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: limit}
        data: {
        }
}

Router.route 'type/:typename/:activityLimit?', {
    name: 'type',
    waitOn: ->
        limit = parse-int this.params.activity-limit
        return Meteor.subscribe 'activities', {sort: {createAt: -1}, limit: limit}
}

Router.route '/login', {
    name: 'login',
}

Router.route '/register', ->
    this.render 'register', {}

Router.route '/createActivity', {
    name: 'createActivity',
    waitOn: ->
        return Meteor.subscribe 'activities'
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