//
//  ContentView.swift
//  VisitorsTracker
//
//  Created by Ashish Chauhan on 11/06/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State var addTowerSheet = false
    @State var towerName = ""
    @State var towerFloors = ""
    @State var towerFlats = ""

    @Environment(\.modelContext) var context
    @Query var savedTowers: [Tower]
    
    var body: some View {
        VStack {
            if savedTowers.count <= 0 {
                ContentUnavailableView.init("Please add some towers to start", systemImage: "tray.fill")
            } else {
                List {
                    ForEach(savedTowers) { tower in
                        NavigationLink("\(tower.name)") {
                            VisitorsView(tower: tower)
                        }
                    }
                    .onDelete { indexSet in
                      for index in indexSet {
                        context.delete(savedTowers[index])
                      }
                    }
                }.listStyle(.plain)
            }
        }
        .padding()
        .navigationTitle("Your towers")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        addTowerSheet = true
                    }, label: {
                        HStack(spacing: 0) {
                            Image(systemName: "plus.circle")
                            Text("Add")
                        }
                    })
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundStyle(.gray)
                    })
                }
            }
            .sheet(isPresented: $addTowerSheet) {
                VStack(spacing: 16) {
                    Text("Enter tower details")
                        .font(.headline)
                        .padding(.bottom, 36)
                    
                    TextField("Enter tower name", text: $towerName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("Enter floors count", text: $towerFloors)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    
                    TextField("Enter flat count", text: $towerFlats)
                        .padding(.vertical, 8)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Done") {
                        let tower = Tower(name: towerName, floors: Int(towerFloors) ?? 0, flats: Int(towerFlats) ?? 0)
                        context.insert(tower)
                        addTowerSheet = false
                    }.padding(.top, 16)
                    
                }.padding()
                .presentationDetents([.medium])
            }
    }
}

#Preview {
    HomeView()
}
