root = exports ? @

root.User = {
    register: (username, password, profile, callback)!->
        options = {
            username:  username
            password: password
            profile:profile
        }
        Accounts.create-user options, callback

    login: (username, password, callback)->
        Meteor.login-with-password username, password, callback

    logout: (callback)->
        Meteor.logout!

    current-user: ->
        return Meteor.user!

    change-password: (old-password, new-password, callback)->
        Accounts.change-password old-password, new-password, callback

    change-information: (profile, callback)->
        user = this.current-user!
        if not user
            callback 1
        else
            id = Meteor.user-id!
            Meteor.users.update id, {$set: {profile: profile}}

}
