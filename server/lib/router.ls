Router.configure {
    layoutTemplate: 'main'
}


Router.route '/', ->
    this.render 'main', {}
