//
//  ContentView.swift
//  ToDoManager-iOS
//
//  Created by dan4 on 09.08.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var taskList = TaskList()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach (taskList.tasks) { task in
                        Text(task.description)
                    }
                    .onDelete(perform: removeItems)
                }
                .navigationTitle("Task List")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                taskList.tasks.append(Task(description: "New Task"))
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
        }.onAppear {
            taskList.tasks.append(Task(description: "Task #1"))
            taskList.tasks.append(Task(description: "Task #2"))
            taskList.tasks.append(Task(description: "Task #3"))
        }
    }
    
    private func removeItems(at offset: IndexSet) {
        taskList.tasks.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.portrait)
    }
}
