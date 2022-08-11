//
//  MainPage.swift
//  ToDoManager-iOS
//
//  Created by Daniil Akifev on 09.08.2022.
//

import SwiftUI

struct MainPage: View {
    @StateObject private var storage = Storage()
    @State private var showingAlert = false
    @FocusState private var isFocusedNewProjectTextField: Bool
    
    fileprivate func doneButton() -> some View {
        return Button(
            action: {
                if showingAlert {
                    storage.createNewProject()
                }
                showingAlert = !showingAlert
            },
            label: {
                Text("Done")
                    .font(.system(.title3))
                    .foregroundColor(Color.white)
            }
        )
        .frame(width: showingAlert ? 100 : 40, height: 40)
        .background(showingAlert ? Color.green : Color.blue)
        .cornerRadius(38.5)
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3
        )
    }
    
    fileprivate func cancelButton() -> some View {
        return Button(
            action: {
                showingAlert = !showingAlert
            },
            label: {
                Text("Cancel")
                    .font(.system(.title3))
                    .foregroundColor(Color.white)
            }
        )
        .frame(width: 110, height: 40)
        .background(Color.blue)
        .cornerRadius(38.5)
        .shadow(color: Color.black.opacity(0.3),
                radius: 3,
                x: 3,
                y: 3
        )
    }
    
    fileprivate func newProjectButton() -> some View {
        return Button(
            action: {
                showingAlert = !showingAlert
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
    
    fileprivate func addNewProjectView() -> VStack<HStack<some View>> {
        return VStack {
            HStack {
                TextField("Enter name", text: $storage.newProject)
                    .focused($isFocusedNewProjectTextField)
                    .onAppear {
                        DispatchQueue.main.async {
                            isFocusedNewProjectTextField = true
                        }
                    }
                    .onSubmit {
                        if showingAlert {
                            storage.createNewProject()
                        }
                        showingAlert = !showingAlert
                    }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach ($storage.projects) { $project in
                        NavigationLink("\(project.name)", destination: TaskListView(project: $project))
                    }
                    .onDelete(perform: storage.deleteProject)
                    if showingAlert {
                        addNewProjectView()
                    }
                }
                .navigationTitle("Projects")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if !showingAlert {
                            newProjectButton()
                        } else {
                            doneButton()
                            cancelButton()
                        }
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
