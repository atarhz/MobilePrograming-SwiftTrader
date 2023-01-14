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


//var listItemsss:[crypto] = [crypto(id: 1,name: "Cardano",code: "ADA"),crypto(id: 2,name: "Bitcoin",code: "BT")]
var listItemsss:[crypto] = []
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
    @State private var listItems = listItemsss
    @State private var currentId = 5
    @State var cryptoCurrentId = 5
    
    var body: some View {
        VStack {
            VStack{
                HStack{
                    NavigationView {
                        Form {
                            
                        }
                        .navigationTitle("Cryptocurrency")
                    }
                }
                HStack {
                    Spacer()
                    Button(action: {
                        showAddSheet.toggle()
                    }, label: {
                        VStack {
                            Image(systemName: "plus.circle")
                        }
                    }).padding()
                    
                }.padding(.top, -280.0)
                    .sheet(isPresented: $showAddSheet){
                        HStack{
                            Button("Back") {showAddSheet.toggle()
                            }.padding([.top, .leading, .bottom], 20.0)
                            Spacer()
                        }
                        
                        HStack{
                           NavigationView {
                                List(searchCollection , id: \.self){ cryptoName in
                                    Button(cryptoName){
                                        if (listItems.first { $0.name == cryptoName } != nil) {
                                                showingAlert = true
                                        } else{
                                            listItems.append(crypto(id: currentId,name: cryptoName, code: cryptoName))
                                            currentId = currentId+1
                                            //showAddSheet = false
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
            }
        
        HStack{
            List{
                ForEach(listItems ,id: \.id){ crypto in
                    HStack{
                        Button(crypto.name + " : " + crypto.price[0].cost ) {
                            cryptoCurrentId = crypto.id
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
                                var f = listItems.first { $0.id == cryptoCurrentId }!
                                Section("Date"){
                                    DatePicker(selection: $startDate,displayedComponents: [.date], label: { Text("From") })
                                    DatePicker(selection: $endDate,displayedComponents: [.date], label: { Text("Until") })
                                }
                                Section("Details"){
                                    Text(f.name + " \(cryptoCurrentId)").bold()
                                    Text(f.price.last?.cost ?? "0" ).bold()
                                }
                                Section("Price"){
                                    List(f.price, id: \.id){ price in
                                        VStack{
                
                                            if price.date <= endDate && price.date >= startDate{
                                                
                                                
                                                Text("\(price.date.formatted(date: .abbreviated, time: .shortened)) : " + price.cost)
                                            }
                                            else {
                                                Text("Invalid Date")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }.onDelete{ IndexSet in
                    listItems.remove(atOffsets: IndexSet)
                }
            }
        }.padding(.top, -230.0)
            }
        }
    }


struct Crypto_Previews: PreviewProvider {
    static var previews: some View {
        Crypto()
    }
}

