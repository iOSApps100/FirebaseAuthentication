import Foundation
import FirebaseAuth // Auth
import FirebaseFirestore // storage

@MainActor // it is replacement of DispatchQueue.main.async from UIKit to made the task in main Queue
final class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User? // Firebase ka user
    @Published var currentUser: User? // apna wala user
    @Published var isError: Bool = false
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init() {
        Task {
            await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async {
        
        if let user = auth.currentUser {
            userSession = user
            await fetchUser(by: user.uid)
        }
    }
    
    func login(email: String, password: String) async {
        
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            // when user already logged in then show them to profile screen else show SignIn screen.
            // that why we set userSession = authResult.user, right after signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUser(by: authResult.user.uid)
            
        } catch {
            isError = true
        }
    }
    
    func createUser(email: String, fullName: String, password: String) async {
        do {
            // See for auth we are provided with email and password but we need to add extra information like fullName we will store this in Database check Firebase for reference.
            let authResult = try await auth.createUser(withEmail: email, password: password)
            await storeUserInFirestore(uid: authResult.user.uid, email: email, fullName: fullName)
        } catch {
            isError = true
        }
    }
    
    func storeUserInFirestore(uid: String, email: String, fullName: String) async {
        
        let user = User(uid: uid, email: email, fullName: fullName)
        do {
            try firestore.collection("users").document(uid).setData(from: user)
        } catch {
            isError = true
        }
        
    }
    
    func fetchUser(by uid: String) async {
        
        do {
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: User.self)
            
        } catch {
            isError = true
        }
    }
    
    func signOut() {
        
        do {
            currentUser = nil
            userSession = nil
            try auth.signOut()
        } catch {
            isError = true
        }
    }
    
    func deleteAccount() async {
        
        do {
            userSession = nil
            currentUser = nil
            deleteUser(by: auth.currentUser?.uid ?? "") // first remove from firestore database and then
            try await auth.currentUser?.delete() // remove from auth if we first remove from auth then we would not be able to find record.
        } catch {
            isError = true
        }
    }
    
    private func deleteUser(by uid: String) {
         firestore.collection("users").document(uid).delete()
    }
    
    func resetPassword(by email: String) async {
        
        do {
            try await auth.sendPasswordReset(withEmail: email)
        } catch {
            isError = true
        }
        
    }
}
