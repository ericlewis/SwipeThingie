//
//  ContentView.swift
//  SwipeThingie
//
//  Created by Eric Lewis on 4/4/20.
//  Copyright © 2020 Eric Lewis. All rights reserved.
//

import SwiftUI
import MapKit

struct MapSnapshot: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.isScrollEnabled = false
    }
}

struct Cell: View {
    var roundedRect: RoundedRectangle {
        RoundedRectangle(cornerRadius: 10)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "gear")
                    .imageScale(.large)
                VStack(alignment: .leading) {
                    Text("Title")
                    Text("Subbbbbb")
                }
            }
            .padding()
            MapSnapshot()
        }
        .aspectRatio(contentMode: .fit)
        .mask(roundedRect)
        .overlay(roundedRect.stroke(Color(.systemGray5), lineWidth: 2))
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Cell()
                Cell()
                Cell()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
