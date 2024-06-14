//
//  ContentView.swift
//  hello-mdoyvr
//
//  Created by Patrick Kelleher on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "sunglasses.fill")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Open shortcuts for the action.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
