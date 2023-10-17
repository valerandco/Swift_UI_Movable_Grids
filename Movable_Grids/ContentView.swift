//
//  ContentView.swift
//  Movable_Grids
//
//  Created by Valera Gassiev on 10/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var colors: [Color] = [.red, .blue, .purple, .yellow, .black, .indigo, .cyan, .brown, .mint, .orange]
    @State private var draggingItem: Color?
    
    var body: some View {
        NavigationStack {
            let columns = Array(repeating: GridItem(spacing: 10), count: 2)
            ScrollView(.vertical){
                LazyVGrid(columns: columns, spacing: 10, content: {
                    ForEach(colors, id: \.self) { color in
                        GeometryReader{
                            let size = $0.size
                            RoundedRectangle(cornerRadius: 10)
                                .fill(color.gradient)
                                .draggable(color){
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.ultraThinMaterial)
                                        .frame(width: 1, height: 1)
                                        .onAppear{
                                            draggingItem = color
                                        }
                                }
                                .dropDestination(for: Color.self){ items, location in
                                    draggingItem = nil
                                    return false
                                } isTargeted: { status in
                                    if let draggingItem, status, draggingItem != color{
                                        if let sourceIndex = colors.firstIndex(of: draggingItem),
                                           let destinationIndex = colors.firstIndex(of: color){
                                            withAnimation(){
                                                let sourceItem = colors.remove(at: sourceIndex)
                                                colors.insert(sourceItem, at: destinationIndex)
                                                
                                            }
                                        }
                                    }
                                        
                                }
                        }
                        .frame(height: 120)
                    }
                })
                .padding(15)
            }
            .navigationTitle("Movable Grid")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
