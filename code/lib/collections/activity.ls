root = exports ? @

root.Activity = {
    collection: new Mongo.Collection('Activity')

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

    delete: (id)->
        if not this.find-by-id id
            return 'error'
        else
            this.collection.remove id
            return 'success'
    # zuo wei fa qi reng de ji he
    find-by-username: (username)->
        this.collection.find {
            $or: [ { "sponsor": username }, { "applyList.applier": username }]
        }

    find-by-id: (id)->
        return this.collection.find-one {_id: id}

    find-by-type: (type)->
        return this.collection.find {type: type}

    add-application: (id, applier-id, credit, phone)->
        applications = this.get-applications id
        if not applications
            return 'error'
        for application in applications
            if application.applier is applier-id
                return 'error'
        applications.push {
            id: applyList.length,
            applier: applier,
            success: false,
            score-of-participator: undefined,
            comment: undefined,
            createAt: new Date(),
            score-of-sponsor: undefined,
        }
        this.collection.update id, {$set: {applyList: applications}}
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

    choose-participator: (id, applier-id)->
        applications = this.get-applications id
        return 'error' if not applications
        find = 0
        for application in applications
            if application.applier = applier-id
                find = 1
                application.success = true
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
        for participartor in participators
            if participator.success and participator.applier is applier-id
                if participator.comment isnt undefined
                    return 'error'
                else
                    participator.comment = comment
                    this.collection.update id, {$set: {applyList: participators}}
                    return 'success'
        return 'error'
}
