//
//  ContentView.swift
//  ff
//
//  Created by OH KAIXIU on 24/8/25.
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var isDone: Bool
    var priority: Int
}

struct ContentView: View {
    @State private var tasks = [
        Task(name: "Do Chinese HW", isDone: false, priority: 1),
        Task(name: "Buy Groceries", isDone: true, priority: 2)
    ]
    
    var body: some View {
        TabView {
            // All Tasks
            List {
                ForEach($tasks) { $task in
                    HStack {
                        Toggle("", isOn: $task.isDone).labelsHidden()
                        VStack(alignment: .leading) {
                            Text(task.name)
                                .strikethrough(task.isDone)
                            Stepper("Priority: \(task.priority)",
                                    value: $task.priority, in: 1...3)
                                .font(.caption)
                        }
                    }
                    .contextMenu {
                        Button("Delete") {
                            tasks.removeAll { $0.id == task.id }
                        }
                        Button("Add Task") {
                            tasks.append(Task(name: "New Task", isDone: false, priority: 1))
                        }
                    }
                }
            }
            .tabItem { Text("All Tasks") }
            
            // Completed Tasks
            List(tasks.filter { $0.isDone }) { task in
                Text("\(task.name) (Priority: \(task.priority))")
            }
            .tabItem { Text("Completed") }
        }
    }
}
