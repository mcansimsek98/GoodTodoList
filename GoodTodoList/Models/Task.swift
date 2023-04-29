//
//  Task.swift
//  GoodTodoList
//
//  Created by Mehmet Can Şimşek on 9.12.2022.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
