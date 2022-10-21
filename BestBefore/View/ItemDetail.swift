//
//  ItemDetail.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/17.
//

import SwiftUI

struct ItemDetail: View {
    @StateObject var vm = ItemViewModel()
    @ObservedObject var notificationManger:NotificationManager
    var emojiText: String
    var itemID: UUID?
    var  itemTitle: String
    var category: String
    var ExpirationDate: Date
    var reminderTime: Date
    var perishability: String
    @State private var isDelete:Bool = false
    @State private var isNotification:Bool = false
    @State private var selectedButton3:Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment: .center){
                    HStack(spacing: 20){
                        Divider()
                        Image(systemName: "tag.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green, in: Circle())
                        VStack(alignment: .leading){
                            Text("Category")
                                .font(.headline)
                                .bold()
                            Text(category)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        Spacer()
                    }
                    .frame(width: 400,height: 80)
                    .padding(.horizontal)
                    HStack(spacing: 20){
                        Divider()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green, in: Circle())
                        VStack(alignment: .leading){
                            Text(" Expiring Date")
                                .font(.headline)
                                .bold()
                            Text(ExpirationDate.formatted(date: .complete, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        Spacer()
                    }
                    .frame(width: 400,height: 80)
                    .padding(.horizontal)
                    
                    HStack(spacing: 20){
                        Divider()
                        Image(systemName: "flag.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green, in: Circle())
                        VStack(alignment: .leading){
                            Text("Perishability")
                                .font(.headline)
                                .bold()
                            Text(perishability)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                        }
                        Spacer()
                        

                    }
                    .frame(width: 400,height: 80)
                    .padding(.horizontal)
                    
                    
                    Spacer()
                    VStack{
                        Button {
                            vm.isWasted(id: itemID ?? UUID())
                        } label: {
                           Label("Waste Bin", systemImage: "xmark.bin.fill")
                                .foregroundColor(.white)
                                .padding(.horizontal,120)
                                .padding(.vertical,12)
                                .background(Color.gray.opacity(0.5), in: RoundedRectangle(cornerRadius: 10))
                                
                        }
                        Button {
                            vm.isConsumed(id: itemID ?? UUID() )
                        } label: {
                           Label("Consumed", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .padding(.horizontal,120)
                                .padding(.vertical,12)
                                .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                
                        }
                    }
                    
                }.padding()
            }.frame(maxWidth: .infinity,alignment: .leading)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            isDelete.toggle()
                        } label: {
                           Image(systemName: "trash.fill")
                        }
                        .alert("Are you Sure", isPresented: $isDelete) {
                            Button(role: .destructive){
                                vm.deleteData(id: itemID ?? UUID())
                                
                            } label: {
                                Text("Delete")
                                    .foregroundColor(.red)
                            }
                        } message: {
                            Text("This action cannot be undone")
                        }

                            

                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            isNotification.toggle()
                        } label: {
                            Image(systemName: "bell.fill")
                        }
                        .alert("Notification", isPresented: $isNotification) {
                            Button(role: .destructive){
                                notificationManger.scheduleNotification(title: itemTitle, expirationDate: ExpirationDate, time: reminderTime, emoji: emojiText)
                                
                            } label: {
                                Text("Schedule")
                                    .foregroundColor(.red)
                            }
                        } message: {
                            Text("Schedule for notification")
                        }
                      
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            Tab()
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text(emojiText)
                            .font(.title)
                    }
                    ToolbarItem(placement: .principal) {
                        Text(itemTitle)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                }
            
            
        }.navigationBarBackButtonHidden()
    }
}

