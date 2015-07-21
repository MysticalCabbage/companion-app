//
//  TeacherStudentsModel.swift
//  class-companion
//
//  Created by Jonathan Davis on 7/17/15.
//  Copyright (c) 2015 Jonathan Davis. All rights reserved.
//

import Foundation

var allTeacherStudents = [TeacherStudent]()

class TeacherStudent: Printable {
  var studentTitle: String
  var studentId: String
  var behaviorTotal: Int
  var attendanceStatus: String
  var description: String {
    return "The student name is \(studentTitle)"
  }
  // initialize the instance with the json data from the snapshot
  init(key: String, json: Dictionary<String, AnyObject>) {
    let currentDate = getCurrentDateInString()
    
    self.studentTitle = json["studentTitle"] as? String ?? "studentTitleMissing"
    self.studentId = key
    self.behaviorTotal = json["behaviorTotal"] as? Int ?? 0
    self.attendanceStatus = json["attendance"]![currentDate] as? String ?? "studentAttendanceMissing"
  }
  
  // when initializing with the snapshot data
  convenience init(snap: FDataSnapshot) {
    //    println("IN INIT THE SNAP VALUE IS \(snap.value)")
    if let json = snap.value as? Dictionary<String, AnyObject> {
      self.init(key: snap.key, json: json)
    }
    else {
      fatalError("errored when initializing with snapshot data")
    }
  }
}



func addNewTeacherStudent(newStudent: TeacherStudent) {
  
  if !studentAlreadyExists(allTeacherStudents, newStudent) {
    allTeacherStudents.append(newStudent)
  }
  
}

func studentAlreadyExists (studentsArray: [TeacherStudent], newStudent: TeacherStudent) -> Bool {
  for singleStudent in studentsArray {
    if singleStudent.studentId == newStudent.studentId {
      return true
    }
  }
  return false
}

func emptyAllTeacherStudentsLocally() {
  allTeacherStudents.removeAll()
  
}
