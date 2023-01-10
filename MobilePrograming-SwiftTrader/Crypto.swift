//
//  Crypto.swift
//  MobilePrograming-SwiftTrader
//
//  Created by ata on 10/01/2023.
//

import SwiftUI

public class crypto {
    var id:Int;
    var name:String;
    var code:String;
    var price:[price]

    init(id: Int, name: String, code: String) {
        self.id   = id
        self.name = name
        self.code  = code
        self.price = [MobilePrograming_SwiftTrader.price(id: 1 ,date:Date.now,cryptoName:name,cost:"5$")]
    }
}

class price {
    var id : Int;
    var date:Date;
    var cryptoName:String;
    var cost:String;

    init(id: Int ,date: Date,cryptoName: String, cost: String) {
        self.id = id
        self.date   = date
        self.cryptoName = cryptoName
        self.cost  = cost
    }
}


var listItems:[crypto] = [crypto(id: 1,name: "Cardano",code: "ADA"),crypto(id: 2,name: "Bitcoin",code: "BT")]
var allCrypto:[String] = ["Sol","Doge","Apex","Tether","Shiba","Luna","Lisk","Nxt"]

struct Crypto: View {
    
    @State private var showCryptoSheet = false
    @State private var showAddSheet = false
    @State private var text = crypto(id: 0,name: "",code: "")
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    @State private var searchText = ""
    @State var searchCollection = allCrypto
    @State private var showingAlert = false
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    showAddSheet.toggle()
                }, label: {
                    VStack {
                        Image(systemName: "plus.circle")
                    }
                })
            }.padding([.bottom, .trailing], 20.0)
                .sheet(isPresented: $showAddSheet){
                    HStack{
                        Button("Back") {showAddSheet.toggle()
                        }.padding([.top, .leading, .bottom], 20.0)
                        Spacer()
                    }
                    Spacer()
                    HStack{
                       NavigationView {
                            List(searchCollection , id: \.self){ cryptoName in
                                Button(cryptoName){
                                    if (listItems.first { $0.name == cryptoName } != nil) {
                                            showingAlert = true
                                    }else{
                                        listItems.append(crypto(id:listItems.count+1,name: cryptoName, code: cryptoName))
                                                    }
                                                }
                                            }
                                            .alert(isPresented: $showingAlert) {
                                                        Alert(title: Text("Error"), message: Text("You have already added this Crypto"), dismissButton: .default(Text("Ok")))
                                                    }
                                            .navigationTitle("Select a Crypto")
                        
                                        }
                                        .searchable(text: $searchText)
                                        .onChange(of: searchText) { index in
                                            if !index.isEmpty {
                                                searchCollection = allCrypto.filter { $0.contains(index) }
                                            } else {
                                                searchCollection = allCrypto
                                            }
                                        }
                    }
                    
                    
                }
            HStack{
                List(listItems, id: \.id) { crypto in
                    HStack{
                        Button(crypto.name + " : " + crypto.price[0].cost ) {
                            text = crypto
                            showCryptoSheet.toggle()
                        }
                        .padding()
                        .sheet(isPresented: $showCryptoSheet){
                            HStack{
                                Button("Back") {          showCryptoSheet.toggle()
                                }.padding([.top, .leading, .bottom], 20.0)
                                Spacer()
                            }.background(Color(red: 0.949, green: 0.949, blue: 0.971)).ignoresSafeArea()
                            Form{
                                Section("Date"){
                                    DatePicker(selection: $startDate,displayedComponents: [.date], label: { Text("From") })
                                    DatePicker(selection: $endDate,displayedComponents: [.date], label: { Text("Until") })
                                }
                                Section("Details"){
                                    Text(text.name).bold()
                                    Text(text.price.last?.cost ?? "0" ).bold()
                                }
                                Section("Price"){
                                    List(text.price, id: \.id){ price in
                                        VStack{
                                            if price.date <= endDate && price.date >= startDate{
                                                Text("\(price.date.formatted(date: .abbreviated, time: .shortened)) : " + price.cost)
                                            }
                                        }
                                    }
                                }
                            }.padding(.top, -20.0)
                        }
                    }
                }
            }.padding(-10.0)
            Spacer()
            HStack {
                Section{
                    Spacer()
                    Button(action: {
                        Crypto()
                    }, label: {
                        VStack {
                            Image(systemName: "bitcoinsign.circle.fill")
                            Text("Crypto")
                        }
                    })
                    Spacer()
                    Spacer()
                    Button(action: {
                        ContentView()
                    }, label: {
                        VStack {
                            Image(systemName: "person.circle")
                            Text("Profile")
                        }
                    })
                }
                Spacer()
            }.padding().background(Color(red: 0.973, green: 0.973, blue: 0.973)).ignoresSafeArea()
        }
    }
}

struct Crypto_Previews: PreviewProvider {
    static var previews: some View {
        Crypto()
    }
}
