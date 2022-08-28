//
//  ItemDetail.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/17.
//

import SwiftUI

struct ItemDetail: View {
    @StateObject var vm = ItemViewModel()
    var itemID: UUID?
    var  itemTitle: String
    var category: String
    var ExpirationDate: Date
    @State private var selectedButton:Bool = false
    @State private var selectedButton2:Bool = false
    @State private var selectedButton3:Bool = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color.gray.opacity(0.09).ignoresSafeArea(.all)
                VStack(alignment: .leading){
                    Text(itemTitle)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.leading)
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
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 15))
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
                    .background(Color.white, in: RoundedRectangle(cornerRadius: 15))
                    .padding(.horizontal)
                    
                    Spacer()
                    HStack{
                        Button {
                            vm.deleteData(id: itemID ?? UUID())
                            
                        } label: {
                           Label("delete", systemImage: "trash")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .buttonBorderShape(.roundedRectangle(radius: 8))

                    }.padding()

                    
                    
                }
                .padding()
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            
        }
    }
}

