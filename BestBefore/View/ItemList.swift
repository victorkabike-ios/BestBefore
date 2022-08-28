//
//  ItemList.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/23.
//

import SwiftUI

struct ItemList: View {
    @StateObject var vm = ItemViewModel()
    var savedEntity :  [DataEntity]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading){
                ForEach(savedEntity){ entity in
                        NavigationLink {
                            ItemDetail(itemID: entity.id ?? UUID(), itemTitle: entity.itemTitle ?? "", category: entity.category ?? "", ExpirationDate: entity.expirationDate ?? Date())
                        } label: {
                            
                            HStack{
                                Button {
                                    
                                } label: {
                                    Text(entity.emoji ?? "")
                                }

                                Text(entity.itemTitle ?? "")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                daysBetween(todayDate: Date(), expiryDate: entity.expirationDate ?? Date())
                                    .foregroundColor(.red)
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .padding()
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                        }

                    }
                Divider()
            }.padding()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
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

