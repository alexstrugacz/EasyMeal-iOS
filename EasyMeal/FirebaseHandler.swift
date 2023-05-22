import CryptoKit
import FirebaseAuth
import AuthenticationServices

class FirebaseManager: NSObject, ObservableObject {
    @Published var isLoggedIn = false
    private var currentNonce: String?
    private var appleID: String?
    
    override init() {
        super.init()
        setupFirebaseAuthStateDidChange()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func setupFirebaseAuthStateDidChange() {
            Auth.auth().addStateDidChangeListener { [weak self] (_, user) in
                self?.isLoggedIn = user != nil
            }
        }
    
    func signOutFromApple() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        // Generate nonce for validation after authentication successful
        self.currentNonce = randomNonceString()
        // Set the SHA256 hashed nonce to ASAuthorizationAppleIDRequest
        request.nonce = sha256(currentNonce!)

        // Present Apple authorization form
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
        
    }

    //IT WORKS!
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

    func signUpWithApple(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [
            .email
        ]
        
        let nonce = randomNonceString()
        currentNonce = nonce
        request.nonce = sha256(nonce)
        
            
    }

    func signInWithApple(_ result: Result<ASAuthorization, Error>) {
        if case .failure(let failure) = result {
            
        } else if case .success(let success) = result {
            if let appleIDCredential = success.credential as? ASAuthorizationAppleIDCredential {
                guard let nonce = currentNonce else {
                    return
                }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    return
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    return
                }
                let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce )
                Task {
                    do {
                        let result = try await Auth.auth().signIn(with: credential)
                        
                        self.isLoggedIn = true
                        
                    } catch {
                        
                    }
                }
            }
                
                
        }
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
