//
//  Perfil.swift
//  RealmLogin
//
//  Created by Miguel Ferrer Fornali on 09/01/2021.
//

import SwiftUI
import RealmSwift

struct Profile: View {
    
    @State private var showAlert = false
    @State private var showProfileEditor = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var email = ""
    @State private var online = ""
    @State private var sex = ""
    @State private var userPhoto = UIImage()
    @Binding var logueado:Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init("bgColor").edgesIgnoringSafeArea(.all)
                if UIScreen.main.bounds.height < 800 {
                    ScrollView {
                        Spacer()
                        VStack {
                            Text("welcome1")
                                .font(.title)
                                .foregroundColor(Color.init("textsInvertedColor"))
                            Text("welcome2")
                                .font(.title)
                                .foregroundColor(Color.init("textsInvertedColor"))
                        }
                        Spacer()
                        VStack {
                            Image(uiImage: userPhoto)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipped()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.black, lineWidth: 5))
                        }
                        Spacer()
                        VStack(spacing: 20) {
                            VStack(alignment: .center) {
                                Text("firstname")
                                    .font(.title2)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                                    .opacity(0.5)
                                Text(firstname)
                                    .font(.title3)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                            }
                            VStack(alignment: .center) {
                                Text("lastname")
                                    .font(.title2)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                                    .opacity(0.5)
                                Text(lastname)
                                    .font(.title3)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                            }
                            VStack(alignment: .center) {
                                Text("email")
                                    .font(.title2)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                                    .opacity(0.5)
                                Text(email)
                                    .font(.title3)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                            }
                        }
                        Spacer()
                        Button {
                            logOut()
                        } label: {
                            Text("logout")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .padding(.all)
                                .background(Color.init("loginButtonColor"))
                                .cornerRadius(40)
                                .shadow(color: Color.black, radius: 4, y: 1)
                        }
                        Spacer()
                    }
                } else {
                    VStack {
                        Spacer()
                        VStack {
                            Text("welcome1")
                                .font(.title)
                                .foregroundColor(Color.init("textsInvertedColor"))
                            Text("welcome2")
                                .font(.title)
                                .foregroundColor(Color.init("textsInvertedColor"))
                        }
                        Spacer()
                        VStack {
                            Image(uiImage: userPhoto)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipped()
                                .clipShape(Circle())
                                .shadow(radius: 10)
                                .overlay(Circle().stroke(Color.black, lineWidth: 5))
                        }
                        Spacer()
                        VStack(spacing: 20) {
                            VStack(alignment: .center) {
                                Text("firstname")
                                    .font(.title2)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                                    .opacity(0.5)
                                Text(firstname)
                                    .font(.title3)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                            }
                            VStack(alignment: .center) {
                                Text("lastname")
                                    .font(.title2)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                                    .opacity(0.5)
                                Text(lastname)
                                    .font(.title3)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                            }
                            VStack(alignment: .center) {
                                Text("email")
                                    .font(.title2)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                                    .opacity(0.5)
                                Text(email)
                                    .font(.title3)
                                    .foregroundColor(Color.init("textsInvertedColor"))
                            }
                        }
                        Spacer()
                        Button {
                            logOut()
                        } label: {
                            Text("logout")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 70)
                                .padding(.all)
                                .background(Color.init("loginButtonColor"))
                                .cornerRadius(40)
                                .shadow(color: Color.black, radius: 4, y: 1)
                        }
                        Spacer()
                    }
                }
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: ProfileEditor(showProfileEditor: self.$showProfileEditor), isActive: self.$showProfileEditor, label: {
                            Text("edit_profile")
                                .font(.title3)
                                .foregroundColor(.init("textsInvertedColor"))
                        })
                    }
                    Spacer()
                }.padding()
                if showAlert {
                    ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage)
                }
            }.onAppear {getUserData()}
            .navigationBarHidden(true)
        }.accentColor(Color.init("secondaryButtonsColor"))
    }
    
    private func logOut() {
        do {
            let realm = try Realm()
            let user:Results<User> = realm.objects(User.self).filter("online = 'Si'")
            
            if user.count > 0 {
                if let user = user.first {
                    try realm.write {
                        user.online = "No"
                    }
                }
                logueado = false
                UserDefaults.standard.removeObject(forKey: "logueado")
            } else {
                print("Usuario actual logueado no encontrado, logOut()")
                alertTitle = Errors().LOGOUT_ERROR_TITLE
                alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
                showAlert = true
            }
        } catch let error as NSError {
            print("Error al cerrar sesion", error.localizedDescription)
            alertTitle = Errors().LOGOUT_ERROR_TITLE
            alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
            showAlert = true
        }
    }
    
    private func getUserData() {
        do {
            let realm = try Realm()
            let user:Results<User> = realm.objects(User.self).filter("online = 'Si'")
            
            if user.count > 0 {
                if let user = user.first {
                    self.email = user.email
                    self.firstname = user.firstname
                    self.lastname = user.lastname
                    self.online = user.online
                    self.sex = user.sex
                    self.userPhoto = UIImage(data: user.photo! as Data)!
                }
            } else {
                print("Error, usuario online no encontrado")
                alertTitle = Errors().DEFAULT_ERROR_TITLE
                alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
                showAlert = true
            }
        } catch let error as NSError {
            print("Error al obtener los datos del usuario logueado", error.localizedDescription)
            alertTitle = Errors().DEFAULT_ERROR_TITLE
            alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
            showAlert = true
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile(logueado: .constant(true))
    }
}
