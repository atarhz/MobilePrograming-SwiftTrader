//
//  MobilePrograming_SwiftTraderApp.swift
//  MobilePrograming-SwiftTrader
//
//  Created by ata on 07/01/2023.
//

import SwiftUI

@main
struct MobilePrograming_SwiftTraderApp: App {
    var body: some Scene {
        WindowGroup {
            //Crypto()
            NavigationView {
                VStack{
                    Spacer()
                    
                    Image(systemName: "bitcoinsign.circle").resizable()
                        .frame(width: 256.0, height: 256.0)
                        .foregroundColor(.yellow)
                    Text("WELCOME TO CIP APP").padding()
                    Spacer()
                    HStack(spacing: 30) {
                        Spacer()
                        NavigationLink(destination: Crypto()) {
                            
                                VStack {
                                    Image(systemName: "bitcoinsign.circle")
                                    Text("Crypto")
                                }
                            
                        }
                        Spacer()
                        
                        NavigationLink(destination: ContentView()) {
                            
                                VStack {
                                    Image(systemName: "person.circle")
                                    Text("Profile")
                                }
                            

                        }
                        Spacer()
                    }
                    .navigationTitle("Home")
                }
                
            }
        }
    }
}
