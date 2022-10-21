//
//  WastedFood.swift
//  BestBefore
//
//  Created by victor kabike on 2022/10/06.
//

import SwiftUI

struct WastedFoodList: View {
    @StateObject var vm = ItemViewModel()
    @StateObject var notificationManager = NotificationManager()
    var savedEntity :  [DataEntity]
   
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading){
                
                ForEach(savedEntity){ entity in
                        NavigationLink {
                            ItemDetail(notificationManger: notificationManager, emojiText: entity.emoji ?? "", itemID: entity.id ?? UUID(), itemTitle: entity.itemTitle ?? "", category: entity.category ?? "", ExpirationDate: entity.expirationDate ?? Date(), reminderTime: entity.notificationTime ?? Date(), perishability: entity.perishability ?? "")
                        } label: {
                            
                            HStack{
                                Button {
                                    
                                } label: {
                                    Text(entity.emoji ?? "")
                                }
                                
                                Text(entity.itemTitle ?? "")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Spacer()
                                daysBetween(todayDate: Date(), expiryDate: entity.expirationDate ?? Date())
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                    
                                Button {
                                    
                                } label: {
                                    Image(systemName: "circle.inset.filled")
                                         .foregroundColor( vm.isExpired(expiryDate: entity.expirationDate ?? Date()) ? Color.red : Color.green)
                                    
                                }

                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                            .background(Color.green.opacity(0.1), in: RoundedRectangle(cornerRadius: 10))
                            .background {
                                if entity.isConsumed{
                                    Rectangle()
                                        .fill(Color.gray)
                                        .frame(height: 2)
                                        
                                }
                            }
                            
                            

                        }

                        
                }
                .padding(.horizontal)
                
                
            }.frame(maxWidth: .infinity,maxHeight: .infinity)
        }
    }
        
        //MARK:- daysBetween
        func daysBetween(todayDate: Date, expiryDate: Date) -> some View {
            
            let day = Calendar.current.dateComponents([.day], from: todayDate, to: expiryDate).day!
            if day > 0 {
                return Text("\(day) days left")
            }else {
                return  Text("Expired")
            }
            
        }
}
 
