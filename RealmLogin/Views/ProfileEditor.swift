//
//  ProfileEditor.swift
//  RealmLogin
//
//  Created by Miguel Ferrer Fornali on 06/01/2021.
//

import SwiftUI
import RealmSwift

struct ProfileEditor: View {
    
    private var disableButton:Bool {
        pass.isEmpty || confirmedPass.isEmpty
    }
    @State private var userPhoto:UIImage? = UIImage()
    @State private var firstname = ""
    @State private var editingFirstname = false
    @State private var lastname = ""
    @State private var editingLastname = false
    @State private var email = ""
    @State private var pass = ""
    @State private var confirmedPass = ""
    @State private var sex = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showPass = false
    @State private var showConfirmedPass = false
    @State private var showImagePicker = false
    @State private var sourceType:UIImagePickerController.SourceType = .camera
    @State private var photoIsSelected = false
    @State private var showActionSheet = false
    @Binding var showProfileEditor:Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.init("bgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    if UIScreen.main.bounds.height < 800 {
                        ScrollView {
                            Button {
                                showActionSheet = true
                            } label: {
                                Image(uiImage: userPhoto!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipped()
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.black, lineWidth: 5))
                            }
                            Spacer()
                            HStack(spacing: 0) {
                                TextField("firstname", text: self.$firstname)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40)
                                    .disabled(true)
                            }
                            HStack(spacing: 0) {
                                TextField("lastname", text: self.$lastname)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40)
                                    .disabled(true)
                            }
                            HStack(spacing: 0) {
                                TextField("email", text: self.$email)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40)
                                    .disabled(true)
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
                                modifyUser(user_password: pass, user_confirmedPassword: confirmedPass, user_photo: userPhoto!)
                            }, label: {
                                Text("save_changes")
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
                            Button {
                                showActionSheet = true
                            } label: {
                                Image(uiImage: userPhoto!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipped()
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.black, lineWidth: 5))
                            }
                            Spacer()
                            HStack(spacing: 0) {
                                TextField("firstname", text: self.$firstname)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40)
                                    .disabled(true)
                            }
                            HStack(spacing: 0) {
                                TextField("lastname", text: self.$lastname)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40)
                                    .disabled(true)
                            }
                            HStack(spacing: 0) {
                                TextField("email", text: self.$email)
                                    .frame(height: 21)
                                    .padding(.all)
                                    .background(Color.init("textsColor").opacity(0.5))
                                    .cornerRadius(40)
                                    .disabled(true)
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
                                modifyUser(user_password: pass, user_confirmedPassword: confirmedPass, user_photo: userPhoto!)
                            }, label: {
                                Text("save_changes")
                                    .foregroundColor(.black)
                                    .frame(width: UIScreen.main.bounds.width - 70)
                                    .padding(.all)
                                    .background(Color.init("loginButtonColor"))
                                    .cornerRadius(40)
                                    .shadow(color: Color.black, radius: 4, y: 1)
                            }).padding(.top, 7)
                            .disabled(disableButton)
                        }.padding()
                    }
                }.sheet(isPresented: self.$showImagePicker) {
                    ImagePicker(selectedImage: self.$userPhoto, isPresented: self.$showImagePicker, photoIsSelected: self.$photoIsSelected, sourceType: self.sourceType).accentColor(Color.init("loginButtonColor"))
                }.actionSheet(isPresented: self.$showActionSheet) {
                    ActionSheet(title: Text("modify_user_photo"), buttons: [
                        .default(Text("gallery_user_photo"), action: {
                            showImagePicker = true
                            sourceType = .photoLibrary
                        }),
                        .default(Text("camera_user_photo"), action: {
                            showImagePicker = true
                            sourceType = .camera
                        }),
                        .destructive(Text("delete_user_photo"), action: {
                            photoIsSelected = false
                            if sex == "male" {
                                userPhoto = UIImage(named: "defaultMaleUserPhoto")!
                            } else if sex == "female" {
                                userPhoto = UIImage(named: "defaultFemaleUserPhoto")!
                            }
                        }),
                        .cancel()
                    ])
                }
                if showAlert {
                    ErrorView(showAlert: self.$showAlert, alertTitle: self.$alertTitle, alertMessage: self.$alertMessage)
                }
            }.onAppear { getUserData() }
            .navigationBarHidden(true)
        }
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
    
    private func getUserData() {
        do {
            let realm = try Realm()
            let user:Results<User> = realm.objects(User.self).filter("online = 'Si'")
            
            if user.count > 0 {
                if let user = user.first {
                    self.email = user.email
                    self.firstname = user.firstname
                    self.lastname = user.lastname
                    self.pass = user.password
                    self.confirmedPass = user.password
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
    
    private func modifyUser(user_password:String, user_confirmedPassword:String, user_photo:UIImage) {
        
        let PASSWORDS_BAD_FORMAT = 0
        let DIFFERENT_PASSWORDS = 1
        let PASSWORDS_OK = 2
        let passwordValidationResponse = validatePasswords(user_password: user_password, user_confirmedPassword: user_confirmedPassword)
        
        if passwordValidationResponse == PASSWORDS_OK {
            do {
                let realm = try Realm()
                let user:Results<User> = realm.objects(User.self).filter("online = 'Si'")
                
                if user.count > 0 {
                    if let user = user.first {
                        try realm.write {
                            user.password = user_password
                            user.photo = NSData(data: userPhoto!.jpeg(.medium)!)
                        }
                        self.showProfileEditor = false
                    } else {
                        print("Usuario introducido first no encontrado")
                    }
                } else {
                    print("Ningun usuario con los datos introducidos")
                    alertTitle = Errors().DEFAULT_ERROR_TITLE
                    alertMessage = Errors().UNEXPECTED_ERROR_MESSAGE
                    showAlert = true
                }
            } catch let error as NSError {
                print("Error al comprobar el usuario para loguear", error.localizedDescription)
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
    }
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(showProfileEditor: .constant(true))
    }
}
