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
                    Button(
                        action: {
                            project.tasks.append(Task(description: "New Task"))
                        },
                        label: {
                            Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 57, height: 50)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                        }
                    )
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3),
                        radius: 3,
                        x: 3,
                        y: 3
                    )
                }
            }
        }
    }
    
    private func removeItems(at offset: IndexSet) {
        project.tasks.remove(atOffsets: offset)
    }
}
