//
//  MainModel.swift
//  ToDoManager-iOS
//
//  Created by dan4 on 09.08.2022.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var description: String
    var isDone: Bool = false
}

class TaskList: ObservableObject {
    @Published var tasks: [Task] = []
}
