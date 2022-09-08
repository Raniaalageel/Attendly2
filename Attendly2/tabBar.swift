//
//  tabBar.swift
//  Attendly2
//
//  Created by Rania Alageel on 12/02/1444 AH.
//

import SwiftUI
//import Firebase


struct tabBar: View {
    var body: some View {
        TabView{
            Home()
                .tabItem(){
                    Image(systemName: "book.closed")
                    Text("Courses")
                }
            //change next line (@R & S)
            NFCtagView()
                .tabItem(){
                    Image(systemName: "checkmark.diamond.fill")
                    Text("Check In")
                }
            Uprofile() 
                .tabItem(){
                                    Image(systemName: "person.fill")
                                    Text("Profile")
                                }
                        }
                    }
                }

                struct tabBar_Previews: PreviewProvider {
                    static var previews: some View {
                        tabBar()
                    }
                }
