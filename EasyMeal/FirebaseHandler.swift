
import FirebaseAuth
import AuthenticationServices

class FirebaseManager: NSObject, ObservableObject {
    @Published var isLoggedIn = false
    private var currentNonce: String?
    private var appleID: String?
    
    func signOutFromApple() {
        // Remove the stored user identifier or tokens used for Apple authentication
        // You can use your own logic or storage mechanism here
        appleID = nil // Clear the stored Apple ID identifier

        // Update the isLoggedIn state accordingly
        isLoggedIn = false

        // Perform any additional sign-out steps specific to your app
    }

    func forgotPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] (error) in
            if let error = error {
                print("Password reset error: \(error.localizedDescription)")
            } else {
                // Password reset email sent successfully
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error {
                print("Sign-up error: \(error.localizedDescription)")
            } else {
                self?.isLoggedIn = true
                print("logged in")
            }
        }
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
            } else {
                self?.isLoggedIn = true
                // Handle successful sign-in
            }
        }
    }
    
    func signOut() {
            do {
                try Auth.auth().signOut()
                isLoggedIn = false
            } catch {
                print("Sign-out error: \(error.localizedDescription)")
            }
        }

    func signUpWithApple() {
        let nonce = randomNonceString()
        currentNonce = nonce

        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = nonce

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    private func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var nonce = ""
        let maxIndex = UInt32(charset.count)

        for _ in 0..<length {
            let randomIndex = Int(arc4random_uniform(maxIndex))
            nonce.append(charset[randomIndex])
        }

        return nonce
    }
}

extension FirebaseManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Return the window or view controller from which to present the Sign In with Apple UI
        // For example:
        return UIApplication.shared.windows.first!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                print("Invalid state: A login callback was received, but no login request was sent.")
                return
            }
            
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token.")
                return
            }
            
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data.")
                return
            }
            
            let email = appleIDCredential.email ?? ""
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                if let error = error {
                    print("Sign-in with Apple error: \(error.localizedDescription)")
                } else {
                    self?.isLoggedIn = true
                    // Handle successful sign-in with Apple
                }
            }
        }
    }
}
