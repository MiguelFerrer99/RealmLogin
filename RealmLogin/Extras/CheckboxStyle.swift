//
//  CheckboxStyle.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 10/11/2020.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? Color.init("secondaryButtonsColor") : .black)
                .font(.system(size: 20, weight: .bold, design: .default))
            configuration.label
            Spacer()
        }.onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
