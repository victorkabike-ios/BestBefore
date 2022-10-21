//
//  Home.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import SwiftUI

struct Home: View {
    @Namespace var namespace
    @State var  showSideMenu: Bool = false
    @StateObject var vm = ItemViewModel()
    @StateObject var notificationManager = NotificationManager()
    @State private var showDetail:Bool = false
    @State var tabselected : Bool = false
    
    var body: some View {
        VStack{
            HeaderView()
            ZStack(alignment: .top){
                //Color.gray.opacity(0.1).ignoresSafeArea(.all)
                LazyVStack(pinnedViews: [.sectionHeaders]){
                    Section {
                        ItemList(savedEntity: vm.savedEntity)
                    } header: {
                        HStack{
                            Text("Expiry Food")
                                .bold()
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    

                }
                
                Button {
                    vm.newitem.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(.largeTitle)
                        
                }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing)
                    .padding()
                    .sheet(isPresented: $vm.newitem) {
                        //NewItem(notificationManger: notificationManager)
                        NewFood(notificationManger: NotificationManager())

                            
                    }
                    

            }
        }
        .refreshable {
            vm.fetchData()
        }
        .navigationBarBackButtonHidden()
    }
    @ViewBuilder
    func HeaderView() -> some View {
        ZStack{
            Color.green.ignoresSafeArea(.all)
            HStack{
                VStack(alignment: .leading){
                    Text("Hey")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    Text("Keep track of your Expiry food")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }.frame(maxWidth: .infinity,alignment: .leading)
                NavigationLink {
                    WastedFoodList(savedEntity: vm.WastedFoodEntity)
                } label: {
                        Image(systemName: "arrow.up.bin.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.white.opacity(0.1), in: Circle())
                }

               


            }.padding()
        }.frame(height: 120, alignment: .top)
    }
    
   
 
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(ItemViewModel())
    }
}
