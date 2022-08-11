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

struct Project: Identifiable {
    let id = UUID()
    var name: String
    var tasks: [Task] = []
}

final class Storage: ObservableObject {
    @Published var projects: [Project] = [
        Project(name: "Inbox"),
        Project(name: "Today"),
        Project(name: "Someday")
    ]
    
    func deleteProject(at offset: IndexSet) {
        projects.remove(atOffsets: offset)
    }
}
