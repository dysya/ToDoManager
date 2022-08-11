//
//  ContentView.swift
//  ToDoManager-iOS
//
//  Created by dan4 on 09.08.2022.
//

import SwiftUI
import CoreData

struct TaskListView: View {
    @Binding var project: Project
    
    fileprivate func newTaskButton() -> some View {
        return Button(
            action: {
                project.tasks.append(Task(description: "New Task"))
            },
            label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
            }
        )
        .frame(width: 40, height: 40)
        .background(Color.blue)
        .cornerRadius(38.5)
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3
        )
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach (project.tasks) { task in
                    Text(task.description)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle(project.name)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    newTaskButton()
                }.padding()
            }
        }
    }
    
    private func removeItems(at offset: IndexSet) {
        project.tasks.remove(atOffsets: offset)
    }
}
