//
//  MainPage.swift
//  ToDoManager-iOS
//
//  Created by Daniil Akifev on 09.08.2022.
//

import SwiftUI

struct MainPage: View {
    
    @StateObject var storage = Storage()
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach ($storage.projects) { $project in
                        NavigationLink("\(project.name)", destination: TaskListView(project: $project))
                    }
                    .onDelete(perform: storage.deleteProject)
                }
                .navigationTitle("Projects")
                VStack {
                    Spacer()
                    HStack {
                        TextField ("TextField", text: $storage.newProject)
                        Spacer()
                        Button ("adsas") {
                            showingAlert = true
                        }.alert ("Enter the name of project", isPresented: $showingAlert, actions: {
                            Button("Add", action: {storage.createNewProject()})
                            Button("Cancel", role: .cancel, action: {})
                        })
                    }.padding()
                }
            }
        }
    }
    
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage().previewInterfaceOrientation(.portrait)
    }
}
