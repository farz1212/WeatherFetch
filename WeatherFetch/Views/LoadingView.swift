//
//  LoadingView.swift
//  WeatherFetch
//
//  Created by Farzaad Goiporia on 2024-06-17.
//

import SwiftUI

//Custom progressView
struct LoadingView: View {
    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView()
}
