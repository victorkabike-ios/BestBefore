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
    var body: some View {
        VStack{
            HeaderView()
            ZStack{
                Color.gray.opacity(0.1).ignoresSafeArea(.all)
                ScrollView {
                    LazyVStack(alignment: .leading){
                            ForEach(vm.savedEntity){ entity in
                                HStack{
                                    Image(systemName: "circle")
                                        .foregroundColor(.green)
                                    Text(entity.itemTitle ?? "")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text(" \(vm.daysBetween(todayDate: Date(), expiryDate: entity.expirationDate ?? Date())) days Left")
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding()
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                                .onTapGesture {
                                    showDetail.toggle()
                                }
                                .sheet(isPresented: $showDetail) {
                                    NavigationStack{
                                        VStack(alignment: .leading){
                                            HStack{
                                                Text("Category : ")
                                                    .frame(maxWidth: .infinity , alignment: .leading)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                    .bold()
                                                Text(entity.category ?? "")
                                            }
                                            .padding()
                                            .background(Color.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                                            HStack{
                                                Text("Expiration Date: ")
                                                    .frame(maxWidth: .infinity , alignment: .leading)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                    .bold()
                                                Text(entity.expirationDate?.formatted(date: .abbreviated, time: .omitted) ?? Date().formatted(date: .abbreviated, time: .omitted))
                                            }
                                            .padding()
                                            .background(Color.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                                            Spacer()
                                                Button {
                                                
                                                } label: {
                                                    Text("Edit")
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal,180)
                                                        .padding(.vertical,12)
                                                        .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                                    
                                                    
                                                }

                                        }.navigationTitle(entity.itemTitle ?? "")
                                            .navigationBarTitleDisplayMode(.large)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        Spacer()
                                        
                                    }.presentationDetents([.fraction(0.5)])
                                }
                            }
                    }.padding()
                }.frame(maxWidth: .infinity,maxHeight: .infinity)
                Button {
                    vm.newitem.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(.largeTitle)
                        
                }.frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing)
                    .padding()
                    .sheet(isPresented: $vm.newitem) {
                        NewItem(notificationManger: notificationManager)
                            
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
                    Text("Keep track of your Expiry food")
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
