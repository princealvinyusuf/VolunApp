//
//  Volunteer.swift
//  Voluny
//


import Foundation

class Volunteer{
    private var _name: String
    private var _email: String
    private var _date: String
    private var _phone: String
    private var _profileURL: String
    private var _ID: String
    
    var name: String{
        return _name
    }
    
    var email: String{
        return _email
    }
    
    var date: String{
        return _date
    }
    
    var phone: String{
        return _phone
    }
    
    
    var profileURL: String{
        return _profileURL
    }
    
    var ID: String{
        return _ID
    }
    
    init(name: String, email: String, date: String, phone: String, profileURL: String, ID: String) {
        self._name = name
        self._email = email
        self._date = date
        self._phone = phone
        self._profileURL = profileURL
        self._ID = ID
    }
    
}
