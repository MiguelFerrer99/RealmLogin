//
//  SignUp.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 31/10/2020.
//

import SwiftUI
import RealmSwift

struct SignUp: View {
    
    private var disableButton:Bool {
        firstname.isEmpty || lastname.isEmpty || email.isEmpty || pass.isEmpty || confirmedPass.isEmpty || sex.isEmpty
    }
    @State private var firstname = ""
    @State private var editingFirstname = false
    @State private var lastname = ""
    @State private var editingLastname = false
    @State private var email = ""
    @State private var editingEmail = false
    @State private var pass = ""
    @State private var confirmedPass = ""
    @State private var sex = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showPass = false
    @State private var showConfirmedPass = false
    @Binding var showSignUp:Bool
    @Binding var logueado:Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init("bgColor").edgesIgnoringSafeArea(.all)
                ZStack {
                    if UIScreen.main.bounds.height < 800 {
                        ScrollView {
                            Spacer()
                            HStack(spacing: 0) {
                                TextField("firstname", text: self.$firstname) { (focused) in
                                    if focused {
                                        editingFirstname = true
                                    } else {
                                        editingFirstname = false
                                    }
                                }.frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textContentType(.oneTimeCode)
                                HStack {
                                    if !firstname.isEmpty && editingFirstname {
                                        Button {
                                            firstname = ""
                                        } label: {
                                            Image(systemName: "multiply.circle.fill")
                                                .resizable()
                                                .frame(width: 21, height: 21)
                                                .opacity(0.7)
                                                .foregroundColor(Color.init("textsInvertedColor"))
                                        }.padding(.trailing)
                                    }
                                }.frame(width: 21, height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topRight, .bottomRight])
                            }
                            HStack(spacing: 0) {
                                TextField("lastname", text: self.$lastname) { (focused) in
                                    if focused {
                                        editingLastname = true
                                    } else {
                                        editingLastname = false
                                    }
                                }.frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textContentType(.oneTimeCode)
                                HStack {
                                    if !lastname.isEmpty && editingLastname {
                                        Button {
                                            lastname = ""
                                        } label: {
                                            Image(systemName: "multiply.circle.fill")
                                                .resizable()
                                                .frame(width: 21, height: 21)
                                                .opacity(0.7)
                                                .foregroundColor(Color.init("textsInvertedColor"))
                                        }.padding(.trailing)
                                    }
                                }.frame(width: 21, height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topRight, .bottomRight])
                            }
                            HStack(spacing: 0) {
                                Spacer()
                                Text("select_sex")
                                Spacer()
                                Spacer()
                                Spacer()
                                Picker(selection: self.$sex, label: Text("select_sex"), content: {
                                    Text("male").tag("male")
                                    Text("female").tag("female")
                                }).pickerStyle(SegmentedPickerStyle())
                                .padding(.leading).padding(.trailing)
                            }
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
                                        }.padding(.trailing)
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
                            HStack(spacing: 0) {
                                if showConfirmedPass {
                                    TextField("confirm_pass", text: self.$confirmedPass)
                                        .frame(height: 21)
                                        .padding(.all)
                                        .background(Color.init("textsColor").opacity(0.5))
                                        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                        .textContentType(.oneTimeCode)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .textContentType(.oneTimeCode)
                                } else {
                                    SecureField("confirm_pass", text: self.$confirmedPass)
                                        .frame(height: 21)
                                        .padding(.all)
                                        .background(Color.init("textsColor").opacity(0.5))
                                        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                        .textContentType(.oneTimeCode)
                                }
                                HStack {
                                    if !confirmedPass.isEmpty {
                                        Button {
                                            showConfirmedPass.toggle()
                                        } label: {
                                            Image(systemName: showConfirmedPass ? "eye.slash.fill" : "eye.fill")
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
                            Spacer()
                            Button(action: {
                                createUser(user_firstname: firstname, user_lastname: lastname, user_email: email, user_password: pass, user_confirmedPassword: confirmedPass, user_sex: sex)
                            }, label: {
                                Text("sign_up")
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.main.bounds.width - 70)
                                    .padding(.all)
                                    .background(Color.init("loginButtonColor"))
                                    .cornerRadius(40)
                                    .shadow(color: Color.black, radius: 4, y: 1)
                            }).padding(.top, 7)
                            .disabled(disableButton)
                        }
                    } else {
                        VStack {
                            Spacer()
                            HStack(spacing: 0) {
                                TextField("firstname", text: self.$firstname) { (focused) in
                                    if focused {
                                        editingFirstname = true
                                    } else {
                                        editingFirstname = false
                                    }
                                }.frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textContentType(.oneTimeCode)
                                HStack {
                                    if !firstname.isEmpty && editingFirstname {
                                        Button {
                                            firstname = ""
                                        } label: {
                                            Image(systemName: "multiply.circle.fill")
                                                .resizable()
                                                .frame(width: 21, height: 21)
                                                .opacity(0.7)
                                                .foregroundColor(Color.init("textsInvertedColor"))
                                        }.padding(.trailing)
                                    }
                                }.frame(width: 21, height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topRight, .bottomRight])
                            }
                            HStack(spacing: 0) {
                                TextField("lastname", text: self.$lastname) { (focused) in
                                    if focused {
                                        editingLastname = true
                                    } else {
                                        editingLastname = false
                                    }
                                }.frame(height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                                .textContentType(.oneTimeCode)
                                HStack {
                                    if !lastname.isEmpty && editingLastname {
                                        Button {
                                            lastname = ""
                                        } label: {
                                            Image(systemName: "multiply.circle.fill")
                                                .resizable()
                                                .frame(width: 21, height: 21)
                                                .opacity(0.7)
                                                .foregroundColor(Color.init("textsInvertedColor"))
                                        }.padding(.trailing)
                                    }
                                }.frame(width: 21, height: 21)
                                .padding(.all)
                                .background(Color.init("textsColor").opacity(0.5))
                                .cornerRadius(40, corners: [.topRight, .bottomRight])
                            }
                            HStack(spacing: 0) {
                                Spacer()
                                Text("select_sex")
                                Spacer()
                                Spacer()
                                Spacer()
                                Picker(selection: self.$sex, label: Text("select_sex"), content: {
                                    Text("male").tag("male")
                                    Text("female").tag("female")
                                }).pickerStyle(SegmentedPickerStyle())
                                .padding(.leading).padding(.trailing)
                            }
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
                                        }.padding(.trailing)
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
                            HStack(spacing: 0) {
                                if showConfirmedPass {
                                    TextField("confirm_pass", text: self.$confirmedPass)
                                        .frame(height: 21)
                                        .padding(.all)
                                        .background(Color.init("textsColor").opacity(0.5))
                                        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                        .textContentType(.oneTimeCode)
                                        .autocapitalization(.none)
                                        .disableAutocorrection(true)
                                        .textContentType(.oneTimeCode)
                                } else {
                                    SecureField("confirm_pass", text: self.$confirmedPass)
                                        .frame(height: 21)
                                        .padding(.all)
                                        .background(Color.init("textsColor").opacity(0.5))
                                        .cornerRadius(40, corners: [.topLeft, .bottomLeft])
                                        .textContentType(.oneTimeCode)
                                }
                                HStack {
                                    if !confirmedPass.isEmpty {
                                        Button {
                                            showConfirmedPass.toggle()
                                        } label: {
                                            Image(systemName: showConfirmedPass ? "eye.slash.fill" : "eye.fill")
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
                            Spacer()
                            Button(action: {
                                createUser(user_firstname: firstname, user_lastname: lastname, user_email: email, user_password: pass, user_confirmedPassword: confirmedPass, user_sex: sex)
                            }, label: {
                                Text("sign_up")
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.main.bounds.width - 70)
                                    .padding(.all)
                                    .background(Color.init("loginButtonColor"))
                                    .cornerRadius(40)
                                    .shadow(color: Color.black, radius: 4, y: 1)
                            }).padding(.top, 7)
                            .disabled(disableButton)
                        }
                    }
                }.padding(.all).onAppear {
                    cleanContents()
                }
                if showAlert {
                    ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage)
                }
            }
            .navigationBarTitle(Text("sign_up"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showSignUp.toggle()
            }, label: {
                Image(systemName: "multiply.circle.fill")
                    .font(.title)
                    .foregroundColor(.gray)
            }))
        }
    }
    
    private func createUser(user_firstname: String, user_lastname:String, user_email:String, user_password:String, user_confirmedPassword:String, user_sex:String) {
        
        let EMAIL_BAD_FORMAT = 0
        let EMAIL_ALREADY_USED = 1
        let EMAIL_OK = 2
        let PASSWORDS_BAD_FORMAT = 0
        let DIFFERENT_PASSWORDS = 1
        let PASSWORDS_OK = 2
        let passwordValidationResponse = validatePasswords(user_password: user_password, user_confirmedPassword: user_confirmedPassword)
        let emailValidationResponse = validateEmail(user_email: user_email)
        
        if emailValidationResponse == EMAIL_OK {
            if passwordValidationResponse == PASSWORDS_OK {
                do {
                    let realm = try Realm()
                    let newUser = User()
                    newUser.firstname = user_firstname
                    newUser.lastname = user_lastname
                    newUser.email = user_email
                    newUser.password = user_password
                    newUser.online = "Si"
                    newUser.sex = user_sex
                    if user_sex == "male" {
                        let defaultMaleUserPhoto = UIImage(named: "defaultMaleUserPhoto")
                        newUser.photo = NSData(data: defaultMaleUserPhoto!.pngData()!)
                    } else if user_sex == "female" {
                        let defaultFemaleUserPhoto = UIImage(named: "defaultFemaleUserPhoto")
                        newUser.photo = NSData(data: defaultFemaleUserPhoto!.pngData()!)
                    }
                    try realm.write {
                        realm.add(newUser)
                        print("newUser guardado")
                    }
                    logueado = true
                } catch let error as NSError {
                    print("Error al guardar", error.localizedDescription)
                }
            } else if passwordValidationResponse == DIFFERENT_PASSWORDS {
                alertTitle = Errors().REGISTRATION_ERROR_TITLE
                alertMessage = Errors().DIFFERENT_PASSWORDS_ERROR_MESSAGE
                showAlert = true
            } else if passwordValidationResponse == PASSWORDS_BAD_FORMAT {
                alertTitle = Errors().REGISTRATION_ERROR_TITLE
                alertMessage = Errors().PASSWORD_BAD_FORMAT_ERROR_MESSAGE
                showAlert = true
            }
        } else if emailValidationResponse == EMAIL_ALREADY_USED {
            alertTitle = Errors().REGISTRATION_ERROR_TITLE
            alertMessage = Errors().EMAIL_USED_ERROR_MESSAGE
            showAlert = true
        } else if emailValidationResponse == EMAIL_BAD_FORMAT {
            alertTitle = Errors().REGISTRATION_ERROR_TITLE
            alertMessage = Errors().EMAIL_BAD_FORMAT_ERROR_MESSAGE
            showAlert = true
        }
    }
    
    private func validateEmail(user_email:String) -> Int {
        
        let EMAIL_BAD_FORMAT = 0
        let EMAIL_ALREADY_USED = 1
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
            emailResponse = EMAIL_ALREADY_USED
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
    
    private func validatePasswords(user_password:String, user_confirmedPassword:String) -> Int {
        let PASSWORDS_BAD_FORMAT = 0
        let DIFFERENT_PASSWORDS = 1
        let PASSWORDS_OK = 2
        var passwordsResponse = PASSWORDS_OK
        
        if user_password != user_confirmedPassword {
            passwordsResponse = DIFFERENT_PASSWORDS
        } else {
            let passwordFormat = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}$"
            let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordFormat)
            if !passwordPredicate.evaluate(with: user_password) {
                passwordsResponse = PASSWORDS_BAD_FORMAT
            }
        }
        
        return passwordsResponse
    }
    
    private func cleanContents() {
        firstname = ""
        lastname = ""
        email = ""
        pass = ""
        confirmedPass = ""
        sex = ""
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(showSignUp: .constant(true), logueado: .constant(false))
    }
}
