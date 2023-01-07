//
//  ContentView.swift
//  MobilePrograming-SwiftTrader
//
//  Created by ata on 07/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSettingsSheet = false
    @State private var showEditTextSheet = false
    @State private var isCaps = false
    @State private var text = "TheProAta"
    
    private var displayedText: String {
        return self.isCaps ? text.uppercased() : text
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Edit") {
                    showSettingsSheet.toggle()
                }
                .padding()
                .sheet(isPresented: $showSettingsSheet){
                    Form{
                        Section("Settings") {
                                Button("Change Username") {
                                    showEditTextSheet.toggle()
                                }
                                Button("Done") {
                                    showSettingsSheet.toggle()
                                }
                        }
                        Section("Preview") {
                            Text("Current Username: \(Text(displayedText).bold())")
                        }
                    }
                    .sheet(isPresented: $showEditTextSheet){
                        Form{
                            Section("Change the text") {
                                TextField("Edit the current Username", text: $text)
                                        Button("Submit") {
                                            showEditTextSheet.toggle()
                                        }
                            }
                        }
                    }
                }
            }
            
            Section{
                
                HStack{
                    Text("Username: \(Text(displayedText).bold())")
                    Spacer()
                }.padding()
                
                Spacer()
                HStack {
                    Section{
                        Spacer()
                        Button(action: {
                            print("fu")
                        }, label: {
                            VStack {
                                Image(systemName: "bitcoinsign.circle")
                                Text("Crypto")
                            }
                        })
                        Spacer()
                        Spacer()
                        Button(action: {
                            print("fu")
                        }, label: {
                            VStack {
                                Image(systemName: "person.circle.fill")
                                Text("Profile")
                            }
                        })
                    }
                    Spacer()
                }.padding().background(Color(red: 0.973, green: 0.973, blue: 0.973)).ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
