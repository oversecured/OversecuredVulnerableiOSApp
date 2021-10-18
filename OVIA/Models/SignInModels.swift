struct SignInModel {
    let email: String
    let password: String
}

extension SignInModel: Encodable {
}
