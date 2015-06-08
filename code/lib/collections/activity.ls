root = exports ? @

root.Activity = {
    collection: new Mongo.Collection('Activity')

    temporary-container: []

    all: ->
        return this.collection.find!

    insert: (name, num-of-people,  deadline, place, cover, startingTime, endingTime, open-or-not, type, sponsor, description)->
        return this.collection.insert {
            name: name,
            sponsor: sponsor,
            num-of-people: num-of-people,
            starting-time: startingTime,
            ending-time: startingTime,
            deadline: deadline,
            place: place,
            open-or-not: open-or-not,
            type: type,
            cover: cover,
            applyList: [],
            description: description
            # aver-sponsor-score: undefined
        }

    update: (id, name, num-of-people,  deadline, place, cover, startingTime, endingTime, open-or-not, type, sponsor, description)->
<<<<<<< HEAD

        return this.collection.update {_id: id},
=======
        return this.collection.update (
            {_id: id}
>>>>>>> d194740507b3697bedb06e756727f3add283c55a
            {$set:
                {
                    name: name,
                    sponsor: sponsor,
                    num-of-people: num-of-people,
                    starting-time: startingTime,
                    ending-time: startingTime,
                    deadline: deadline,
                    place: place,
                    open-or-not: open-or-not,
                    type: type,
                    cover: cover,
                    description: description
                }

            }
<<<<<<< HEAD

=======
        )
>>>>>>> d194740507b3697bedb06e756727f3add283c55a

    delete: (id)->
        if not this.find-by-id id
            return 'error'
        else
            this.collection.remove id
            return 'success'
    # zuo wei fa qi reng de ji he
    find-by-username-has-not-participated: (username)->
        this.collection.find {
            $or: [
                {"sponsor": username},
                {
                    "applyList": {
                        $elemMatch: {
                            "applier-name": username,
                            "success": false
                                    }
                                }
                }
            ]
        }
    find-by-username-as-sponor: (sponsor)->
        this.collection.find {
            "sponsor": sponsor
        }
    find-by-username-has-participated: (username)->
        this.collection.find {
            $or: [
                {"sponsor": username},
                {
                    "applyList": {
                        $elemMatch: {
                            "applier-name": username,
                            "success": true
                                    }
                                }
                }
            ]
        }

    find-by-username: (username)->
        this.collection.find {
            "applyList.applier-name": username
        }


    find-by-id: (id)->
        return this.collection.find-one {_id: id}

    find-by-type: (type)->
        return this.collection.find {type: type}

    add-application: (id, applier-id, credit, phone)->
        applications = this.get-applications id
        if applications
            for application in applications
                if application.applier is applier-id
                    return 'already applied'
        applications.push {
            applier-name: Meteor.users.find-one {_id: applier-id} .username
            applier: applier-id,
            success: false,
            score-of-participator: 0,
            comment: '',
            createAt: new Date(),
            score-of-sponsor: 0,
            credit: credit,
            phone: phone
        }
        this.collection.update {_id: id}, {$set: {applyList: applications}}
        return 'success'

    get-applications: (id)->
        activity = this.find-by-id id
        if not activity
            return null
        return activity.applyList

    get-participate-applications: (id)->
        applications = this.get-applications id
        if not applications
            return null
        result = []
        for application in applications
            result.push application if application.success
        return result

    choose-participator: (id, applier-id, select-or-cancle)->
        applications = this.get-applications id
        return 'error' if not applications
        for application in applications
            if application.applier is applier-id
                application.success = select-or-cancle
        this.collection.update id, {$set: {applyList: applications}}
        return 'success'

    calculate-score: (id)->
        participators = this.get-participate-applications id
        scores = 0
        num = 0
        for participator in participators
            if participator.score-of-sponsor
                scores += participator.score-of-sponsor
                ++num
        return scores * 1.0 / num
 
    comment-activity: (id, applier-id, comment)->
        participators = this.get-applications id
        for item in participators
            if item.success and item.applier is applier-id
                if item.comment isnt ''
                    return 'error'
                else
                    item.comment = comment
                    this.collection.update id, {$set: {applyList: participators}}
                    return 'success'
        return 'error'
}
