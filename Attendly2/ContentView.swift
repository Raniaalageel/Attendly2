//
//  ContentView.swift
//  Attendly2
//
//  Created by Rania Alageel on 10/02/1444 AH.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
struct ContentView: View {
   
    @State var email = ""
    @State var pass = ""
    @State var   statusMessage = ""
    @State var   subject = ""
    @State var   section = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    var body: some View {
        NavigationView {
            ZStack {
                Color.green
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Email for student", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                        
                    
                    SecureField("Password", text: $pass)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        loginuser()
                        }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                   
                }
               // NavigationLink(destination: Text("You are logged in @\(username)"), isActive: $showingLoginScreen) {
                             //           EmptyView()
           // }.navigationBarHidden(true)
           
        }
    }
    }
    
     
       
       
            
           
        
  //body
    
    private func loginuser() {
        Auth.auth().signIn(withEmail: email , password: pass) { result ,err in
            if let err = err{
                print("faild",err)
                self.statusMessage="Faild to ligin: \(err)"
            return
            }
            print("sucssfuly:  \(result?.user.uid ?? "") ")
            self.statusMessage="sucffuel is : \(result?.user.uid ?? "")"
           
            
           self.storeUserInformation()
          //  self.moveto()

        }
        // self.storeUserInformation()
    }
    
    private func storeUserInformation(){
        guard let uid=Auth.auth().currentUser?.uid else {return }
        let userData = ["Email":self.email ,"ID":self.pass, "section":self.section, "subject":self.subject,"uid":uid]
        Firestore.firestore().collection("studentApp")
            .document(uid).setData(userData){err in
                if let err = err {
                    print(err)
                    self.statusMessage = "\(err)"
                    return
                }
                //print("sucsee ")
            }
       // self.moveto()
    }  //end func
    
  //  private func moveto(){
      //  nextt()
    //}
    
    
}
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
