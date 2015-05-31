Router.configure {
    layoutTemplate: 'layout'
}


Router.route '/', ->
    this.render 'index', {}

Router.route 'type/:typename', ->
    this.render 'index', {typename: this.params.typename}

Router.route '/login', ->
    this.render 'login', {}

Router.route '/register', ->
    this.render 'register', {}

Router.route '/createActivity', ->
    this.render 'createActivity', {}

Router.route '/profile', ->
    this.render 'profile', {}

Router.route '/activity/:activityId', ->
    this.render 'actiity', {activity-id: this.params.activityId}