//
//  MyVolunteerExperience.swift
//  Voluny
//


import Foundation

class MyVolunteerExperience{
    private var _title: String
    private var _location: String
    private var _date: String
    private var _time: String
    private var _expID: String
    private var _recruiterID: String
    private var _ageGroup: String
    private var _category: String
    private var _applydate: String
    var recruiterID : String{
        return _recruiterID
    }
    
    var title: String{
        return _title
    }
    
    var location: String{
        return _location
    }
    
    var date: String{
        return _date
    }
    
    var time: String{
        return _time
    }
    
    var expID: String{
        return _expID
    }
    
    var ageGroup: String{
        return _ageGroup
    }
    
    var category: String{
        return _category
    }
    
    var applydate: String{
        return _applydate
    }
    
    init(title: String, location: String, date: String, time: String, expID: String, recruiterID: String, ageGroup: String, category: String, applydate: String){
        self._title = title
        self._location = location
        self._date = date
        self._time = time
        self._expID = expID
        self._recruiterID = recruiterID
        self._ageGroup = ageGroup
        self._category = category
        self._applydate = applydate
    }
    
}
