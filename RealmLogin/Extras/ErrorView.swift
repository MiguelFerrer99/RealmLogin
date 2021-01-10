//
//  ErrorView.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 10/11/2020.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var showAlert:Bool
    @Binding var alertTitle:String
    @Binding var alertMessage:String
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                if alertTitle == Errors().LOGIN_ERROR_TITLE {
                    Text("login_error_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().REGISTRATION_ERROR_TITLE {
                    Text("registration_failure_title")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().LOGOUT_ERROR_TITLE {
                    Text("logout_failure")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                } else if alertTitle == Errors().DEFAULT_ERROR_TITLE {
                    Text("default_error")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                Spacer()
                 if alertMessage == Errors().UNEXPECTED_ERROR_MESSAGE {
                    Text("unexpected_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().DIFFERENT_PASSWORDS_ERROR_MESSAGE {
                    Text("different_passwords_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().EMAIL_USED_ERROR_MESSAGE {
                    Text("email_used_error_message")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().EMAIL_BAD_FORMAT_ERROR_MESSAGE {
                    Text("email_bad_format")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().PASSWORD_BAD_FORMAT_ERROR_MESSAGE {
                    Text("password_bad_format")
                        .font(.body)
                        .foregroundColor(.black)
                } else if alertMessage == Errors().EMAIL_NOT_FOUND_ERROR_MESSAGE {
                    Text("email_not_found")
                        .font(.body)
                        .foregroundColor(.black)
                }
                Spacer()
                Button {
                    showAlert = false
                } label: {
                    Text("OK")
                        .frame(width: UIScreen.main.bounds.width-200, alignment: .center)
                        .padding(.all)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
            }.padding(.all)
            .frame(width: UIScreen.main.bounds.width/1.3, height: UIScreen.main.bounds.height/3.8, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.vertical, UIScreen.main.bounds.height/4.5)
            .padding(.horizontal, UIScreen.main.bounds.width/8)
        }.background(Color.black.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(showAlert: .constant(false), alertTitle: .constant(""), alertMessage: .constant(""))
    }
}
