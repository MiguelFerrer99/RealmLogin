//
//  Error.swift
//  NewSignIn
//
//  Created by Miguel Ferrer Fornali on 08/11/2020.
//

import Foundation

class Errors {
    
    //Login and LoginMail error titles:
    let LOGIN_ERROR_TITLE = "login_error_title"
    //Login ans LoginMail error messages:
    let UNEXPECTED_ERROR_MESSAGE = "unexpected_error_message"
    let EMAIL_USED_ERROR_MESSAGE = "email_used_error_message"
    let EMAIL_BAD_FORMAT_ERROR_MESSAGE = "email_bad_format"
    let PASSWORD_BAD_FORMAT_ERROR_MESSAGE = "password_bad_format"
    let EMAIL_NOT_FOUND_ERROR_MESSAGE = "email_not_found"
    
    //SignUp error titles:
    let REGISTRATION_ERROR_TITLE = "registration_failure_title"
    //SignUp error messages:
    let DIFFERENT_PASSWORDS_ERROR_MESSAGE = "different_passwords_message"
    
    //LogOut error titles:
    let LOGOUT_ERROR_TITLE = "logout_failure"
    
    //Default error titles:
    let DEFAULT_ERROR_TITLE = "default_error"
}
