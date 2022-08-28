//
//  Home.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import SwiftUI

struct Home: View {
    @StateObject var vm = ItemViewModel()
    @StateObject var notificationManager = NotificationManager()
    @State private var showDetail:Bool = false
    @State var tabselected : Bool = false
    var body: some View {
        VStack{
            HeaderView()
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea(.all)
                ItemList(savedEntity: vm.savedEntity)
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
                            .presentationDetents([.fraction(0.4)])
                            
                    }
                    

            }
        }
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
                    Text("Keep track of your Expired food")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }.frame(maxWidth: .infinity,alignment: .leading)
                Button {
                    
                } label: {
                    Image("menu")
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
