//
//  ItemDetail.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/17.
//

import SwiftUI

struct ItemDetail: View {
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
                    .padding()
                    
                    
                    
                    HStack(spacing: 20){
                        Divider()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green, in: Circle())
                        VStack(alignment: .leading){
                            Text("Date")
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
                    .padding()
                    
                    Spacer()
                    HStack{
                        Button {
                            
                        } label: {
                           Label("delete", systemImage: "trash")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .buttonBorderShape(.roundedRectangle(radius: 8))
                        Button {
                            
                        } label: {
                           Label("delete", systemImage: "trash")
                                .foregroundColor(.gray)
                        }


                    }.padding()

                    
                    
                }
                .padding()
            }.frame(maxWidth: .infinity,alignment: .leading)
            
            
        }
    }
}

