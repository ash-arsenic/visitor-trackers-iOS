//
//  VisitorsView.swift
//  VisitorsTracker
//
//  Created by Ashish Chauhan on 11/06/24.
//

import SwiftUI
import SwiftData

struct VisitorsView: View {
    @Environment(\.modelContext) var context
    
    @State private var addVisitorSheet = false
    @State private var visitorName = ""
    @State private var visitingFlat = ""
    @State private var visitingPurpose = ""
    @Query var visitors: [Visitor]
    
    let tower: Tower
    
    var body: some View {
        VStack {
            if (visitors.filter { $0.tower.name == self.tower.name }).count == 0 {
                ContentUnavailableView("No visitors today", systemImage: "tray.fill")
            } else {
                List {
                    ForEach((visitors.filter { $0.tower.name == self.tower.name })) { visitor in
                        Text(visitor.name)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    addVisitorSheet = true
                }, label: {
                    HStack(spacing: 0) {
                        Image(systemName: "plus.circle")
                        Text("Add")
                    }
                })
            }
        }.sheet(isPresented: $addVisitorSheet) {
            VStack(spacing: 16) {
                Text("Enter Visitor details")
                    .font(.headline)
                    .padding(.bottom, 36)
                
                TextField("Enter Visitors name", text: $visitorName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Enter visiting flat", text: $visitingFlat)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Enter purpose", text: $visitingPurpose)
                    .padding(.vertical, 8)
                    .textFieldStyle(.roundedBorder)
                
                Button("Done") {
                    let visitor = Visitor(name: visitorName, tower: tower, visiting: visitingFlat, purpose: visitingPurpose)
                    context.insert(visitor)
                    addVisitorSheet = false
                }.padding(.top, 16)
                
            }.padding()
            .presentationDetents([.medium])
        }
    }
}
