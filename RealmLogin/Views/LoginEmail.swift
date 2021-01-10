//
//  LoginEmail.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 30/10/2020.
//

import SwiftUI
import RealmSwift

struct LoginEmail: View {
    
    private var disableButton:Bool {
        email.isEmpty || pass.isEmpty
    }
    @State private var email = ""
    @State private var editingEmail = false
    @State private var pass = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var remindUser = false
    @State private var showSignUp = false
    @State private var showPass = false
    @Binding var logueado:Bool
    
    var body: some View {
        ZStack {
            Color.init("bgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Text("login")
                        .font(.title)
                        .bold()
                }
                Spacer()
                VStack {
                    HStack(spacing: 0) {
                        TextField("email", text: self.$email) { (focused) in
                            if focused {
                                editingEmail = true
                            } else {
                                editingEmail = false
                            }
                        }.frame(height: 21)
                        .padding(.all)
                        .background(Color.init("textsColor").opacity(0.5))
                        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.oneTimeCode)
                        HStack {
                            if !email.isEmpty && editingEmail {
                                Button {
                                    email = ""
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .frame(width: 21, height: 21)
                                        .opacity(0.7)
                                        .foregroundColor(Color.init("textsInvertedColor"))
                                }
                            }
                        }.frame(width: 21, height: 21)
                        .padding(.all)
                        .background(Color.init("textsColor").opacity(0.5))
                        .cornerRadius(40, corners: [.topRight, .bottomRight])
                    }
                    HStack(spacing: 0) {
                        if showPass {
                            TextField("pass", text: self.$pass)
                                .frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .textContentType(.oneTimeCode)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textContentType(.oneTimeCode)
                        } else {
                            SecureField("pass", text: self.$pass)
                                .frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .textContentType(.oneTimeCode)
                        }
                        HStack {
                            if !pass.isEmpty {
                                Button {
                                    showPass.toggle()
                                } label: {
                                    Image(systemName: showPass ? "eye.slash.fill" : "eye.fill")
                                        .frame(width: 21, height: 21)
                                        .foregroundColor(Color.init("textsInvertedColor"))
                                        .opacity(0.7)
                                }
                            }
                        }.frame(width: 21, height: 21)
                        .padding(.all)
                        .background(Color.init("textsColor").opacity(0.5))
                        .cornerRadius(40, corners: [.topRight, .bottomRight])
                    }
                    Button(action: {
                        logIn(userEmail: email, userPassword: pass)
                    }, label: {
                        Text("login")
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width - 70)
                            .padding(.all)
                            .background(Color.init("loginButtonColor"))
                            .cornerRadius(40)
                            .shadow(color: Color.black, radius: 4, y: 1)
                    }).padding(.top, 7)
                    .disabled(disableButton)
                    Toggle(isOn: self.$remindUser, label: {
                        Text("remind_user")
                    }).padding(.top).padding(.leading)
                    .toggleStyle(CheckboxStyle())
                }
                Spacer()
                VStack {
                    Button(action: {
                        showSignUp.toggle()
                    }, label: {
                        Text("go_sign_up")
                    }).foregroundColor(Color.init("secondaryButtonsColor"))
                    .sheet(isPresented: self.$showSignUp, content: {
                        SignUp(showSignUp: self.$showSignUp, logueado: self.$logueado)
                    }).padding(.bottom)
                }
                Spacer()
            }.padding(.all)
            if showAlert {
                ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage)
            }
        }
    }
    
    private func logIn(userEmail:String, userPassword:String) {
        
        let EMAIL_BAD_FORMAT = 0
        let EMAIL_ALREADY_USED = 1
        let EMAIL_OK = 2
        let PASSWORDS_BAD_FORMAT = 0
        let PASSWORDS_OK = 2
        let passwordValidationResponse = validatePassword(user_password: userPassword)
        let emailValidationResponse = validateEmail(user_email: userEmail)
        
        if emailValidationResponse == EMAIL_OK {
            if passwordValidationResponse == PASSWORDS_OK {
                do {
                    let realm = try Realm()
                    let user:Results<User> = realm.objects(User.self).filter("email = '\(userEmail)' AND password = '\(userPassword)'")
                    
                    if user.count > 0 {
                        if let user = user.first {
                            try realm.write {
                                user.online = "Si"
                            }
                            logueado = true
                            if remindUser {
                                UserDefaults.standard.setValue(true, forKey: "logueado")
                            }
                        } else {
                            print("Usuario introducido first no encontrado")
                        }
                    } else {
                        print("Ningun usuario con los datos introducidos")
                        alertTitle = Errors().LOGIN_ERROR_TITLE
                        alertMessage = Errors().EMAIL_NOT_FOUND_ERROR_MESSAGE
                        showAlert = true
                    }
                } catch let error as NSError {
                    print("Error al comprobar el usuario para loguear", error.localizedDescription)
                }
            } else if passwordValidationResponse == PASSWORDS_BAD_FORMAT {
                alertTitle = Errors().LOGIN_ERROR_TITLE
                alertMessage = Errors().PASSWORD_BAD_FORMAT_ERROR_MESSAGE
                showAlert = true
            }
        } else if emailValidationResponse == EMAIL_ALREADY_USED {
            alertTitle = Errors().LOGIN_ERROR_TITLE
            alertMessage = Errors().EMAIL_USED_ERROR_MESSAGE
            showAlert = true
        } else if emailValidationResponse == EMAIL_BAD_FORMAT {
            alertTitle = Errors().LOGIN_ERROR_TITLE
            alertMessage = Errors().EMAIL_BAD_FORMAT_ERROR_MESSAGE
            showAlert = true
        }
    }

    private func validateEmail(user_email:String) -> Int {
        
        let EMAIL_BAD_FORMAT = 0
        let EMAIL_OK = 2
        var emailResponse = EMAIL_OK
        var usersWithThisEmail = 0
        
        do {
            let realm = try Realm()
            let user:Results<User> = realm.objects(User.self).filter("email = '\(user_email)'")
            usersWithThisEmail = user.count
        } catch let error as NSError {
            print("Error al comprobar si existe un usuario con ese email", error.localizedDescription)
        }
        
        if usersWithThisEmail > 0 {
            emailResponse = EMAIL_OK
        }
        else {
            let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
            if !emailPredicate.evaluate(with: user_email) {
                emailResponse = EMAIL_BAD_FORMAT
            }
        }
        
        return emailResponse
    }

    private func validatePassword(user_password:String) -> Int {
        let PASSWORDS_BAD_FORMAT = 0
        let PASSWORDS_OK = 2
        var passwordsResponse = PASSWORDS_OK
        
        let passwordFormat = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
        if !passwordPredicate.evaluate(with: user_password) {
            passwordsResponse = PASSWORDS_BAD_FORMAT
        }
        
        return passwordsResponse
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct LoginEmail_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmail(logueado: .constant(false))
    }
}
