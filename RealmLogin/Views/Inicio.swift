//
//  Inicio.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 29/10/2020.
//

import SwiftUI
import RealmSwift

struct Inicio: View {
    
    @Binding var logueado:Bool
    
    var body: some View {
        TabView {
            News().tabItem {
                Image(systemName: "newspaper.fill")
                Text("my_news")
            }
            Profile(logueado: self.$logueado).tabItem {
                Image(systemName: "person.circle.fill")
                Text("my_profile")
            }
        }
    }
}

struct Inicio_Previews: PreviewProvider {
    static var previews: some View {
        Inicio(logueado: .constant(false))
    }
}
