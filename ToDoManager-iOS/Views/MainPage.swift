//
//  MainPage.swift
//  ToDoManager-iOS
//
//  Created by Daniil Akifev on 09.08.2022.
//

import SwiftUI

struct MainPage: View {
    @StateObject private var storage = Storage()
    @State var newProjectName = ""
    @State private var isNewProjectCellShown = false
    @FocusState private var isFocusedNewProjectTextField: Bool
    
    fileprivate func doneButton() -> some View {
        return Button(
            action: {
                if (!newProjectName.isEmpty) {
                    storage.projects.append(Project(name: newProjectName))
                    newProjectName = ""
                }
                isNewProjectCellShown = !isNewProjectCellShown
            },
            label: {
                Text("Done")
                    .font(.system(.title3))
                    .foregroundColor(Color.white)
            }
        )
        .frame(width: 100, height: 40)
        .background(Color.green)
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
                newProjectName = ""
                isNewProjectCellShown = !isNewProjectCellShown
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
                isNewProjectCellShown = !isNewProjectCellShown
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
    
    fileprivate func addNewProjectView() -> some View {
        return VStack {
            HStack {
                TextField("Enter name", text: $newProjectName)
                    .focused($isFocusedNewProjectTextField)
                    .onAppear {
                        DispatchQueue.main.async {
                            isFocusedNewProjectTextField = true
                        }
                    }
                    .onSubmit {
                        if (!newProjectName.isEmpty) {
                            storage.projects.append(Project(name: newProjectName))
                            newProjectName = ""
                        }
                        isNewProjectCellShown = !isNewProjectCellShown
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
                    .onDelete(perform: deleteProject)
                    if isNewProjectCellShown {
                        addNewProjectView()
                    }
                }
                .navigationTitle("Projects")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if !isNewProjectCellShown {
                            newProjectButton()
                        } else {
                            if (!newProjectName.isEmpty) {
                                doneButton()
                            }
                            cancelButton()
                        }
                    }.padding()
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
