//
//  ContentView.swift
//  RealmLogin
//
//  Created by Miguel Ferrer Fornali on 05/01/2021.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State var logueado = false
    
    var body: some View {
        
        ZStack {
            if logueado {
                Inicio(logueado: self.$logueado)
            } else {
                LoginEmail(logueado: self.$logueado)
            }
        }.onAppear {
            if UserDefaults.standard.object(forKey: "logueado") != nil {
                logueado = true
            }
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
