//
//  MainPage.swift
//  ToDoManager-iOS
//
//  Created by Daniil Akifev on 09.08.2022.
//

import SwiftUI

struct MainPage: View {
    @StateObject var storage = Storage()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach ($storage.projects) { $project in
                        NavigationLink("\(project.name)", destination: TaskListView(project: $project))
                    }
                    .onDelete(perform: deleteProject)
                }
                .navigationTitle("Projects")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                storage.projects.append(Project(name: "New Project"))
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
    }
    
    private func deleteProject(at offset: IndexSet) {
        storage.projects.remove(atOffsets: offset)
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage().previewInterfaceOrientation(.portrait)
    }
}
