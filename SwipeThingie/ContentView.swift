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
    @State var offset: CGFloat = 0

    var roundedRect: RoundedRectangle {
        RoundedRectangle(cornerRadius: 10)
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.width > 0 { return }
                withAnimation { self.offset = value.translation.width }
            }
            .onEnded { _ in withAnimation { self.offset = 0 } }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .trailing) {
                if self.offset < 0 {
                    HStack {
                        Image(systemName: "gear")
                            .padding()
                        Image(systemName: "gear")
                            .padding()
                        Image(systemName: "gear")
                            .padding()
                    }
                    .transition(.scale)
                }
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                            .imageScale(.large)
                            .padding()
                            .background(Circle().fill(Color.secondary))
                        VStack(alignment: .leading) {
                            Text("Title")
                            Text("Subbbbbb")
                                .font(.subheadline)
                            Text("\((self.offset * -1) / geometry.size.width)")
                        }
                    }
                    .padding()
                    MapSnapshot()
                }
                .mask(self.roundedRect)
                .overlay(self.roundedRect.stroke(Color(.systemGray5), lineWidth: 2))
                .offset(x: self.offset)
                .gesture(self.drag)
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
        }
        .aspectRatio(1.5, contentMode: .fit)
        .padding([.horizontal, .bottom])
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
