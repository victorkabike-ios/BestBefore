//
//  NewFood.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/26.
//

import SwiftUI

struct NewFood: View {
    @EnvironmentObject var vm: ItemViewModel
    @ObservedObject var notificationManger:NotificationManager
    @Environment(\.dismiss) var dismiss

    @State private var foodTitle: String = ""
    
    @State private var isEmoji: Bool = false
    @State private var emojiText: String = ""
    
    @State private var showDatePicker: Bool = false
    @State  private var expiredDate = Date()
    @State private var reminderTime = Date()
    
    @State private var showCategory: Bool = false
    enum Category: String , CaseIterable ,Identifiable {
        case  Fruits,Vegetables,Dairy,Meat,FishandSeafood,BreadAndBakery,FrozenFoods, Drink
        var id: Self { self }
    }
    @State private var selectedCategory = Category.Fruits
    
    @State private var showPerishability: Bool = false
    enum Perishability: String ,CaseIterable ,Identifiable {
        case Low, Medium, High
        var id: Self { self}
    }
    @State private var selectedPerishability = Perishability.Low
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    Button {
                        isEmoji.toggle()
                    } label: {
                        Image(systemName: "face.smiling.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(.green, in: Circle())
                    }
                    .sheet(isPresented: $isEmoji) {
                        NavigationStack{
                            EmojiTextField(text: $emojiText, placeholder: "Enter emoji", isEmoji: $isEmoji)
                                .padding(.horizontal)
                                .padding(.vertical,15)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10)
                                )
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        Button("Done") {
                                            isEmoji = false
                                        }
                                    }
                                }
                    }
                }
                    TextField("Add New Food ", text: $foodTitle)
                    Button {
                        vm.addNewEntity(title: foodTitle, category: selectedCategory.rawValue, expirationDate: expiredDate, notificationDate: expiredDate, perishability: selectedPerishability.rawValue, emoji: emojiText, notificationTime: reminderTime)
                        notificationManger.scheduleNotification(title: foodTitle, expirationDate: expiredDate, time: reminderTime)
                        dismiss()
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(.green, in: Circle())
                    }
                    
                    
                }.padding()
                HStack{
                    Button {
                        showDatePicker.toggle()
                    } label: {
                        Label("Today", systemImage: "calendar")
                    }
                    .sheet(isPresented: $showDatePicker) {
                        NavigationStack{
                            VStack{
                                DatePicker("Select Date", selection: $expiredDate,displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .padding()
                                DatePicker(selection: $reminderTime,displayedComponents: .hourAndMinute) {
                                        Label("Notification Time", systemImage: "clock.fill")
                                            .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button {
                                    showDatePicker = false
                                } label: {
                                    Text("Done")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,160)
                                        .padding(.vertical,12)
                                        .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                        
                                }

                                
                            }
                            .padding()
                            
                        }
                    }
                    Button {
                        showCategory.toggle()
                    } label: {
                        Label("Category", systemImage: "tag.fill")
                            .foregroundColor(.secondary)
                    }
                    .sheet(isPresented: $showCategory) {
                        NavigationStack{
                            VStack{
                                Picker("", selection: $selectedCategory) {
                                    ForEach(Category.allCases){ item in
                                        Text(item.rawValue)
                                    }
                                }.pickerStyle(.wheel)
                                Button {
                                    showCategory = false
                                } label: {
                                    Text("Done")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,160)
                                        .padding(.vertical,12)
                                        .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                        
                                }
                                

                            }
                        }
                    }
                    Button {
                        showPerishability.toggle()
                    } label: {
                        Label("Perishability", systemImage: "flag.fill")
                            .foregroundColor(.secondary)
                    }
                    .sheet(isPresented: $showPerishability) {
                        NavigationStack{
                            VStack{
                                Picker("", selection: $selectedPerishability) {
                                    ForEach(Perishability.allCases){ perishability in
                                        Text(perishability.rawValue)
                                    }
                                }.pickerStyle(.wheel)
                                Button {
                                    showPerishability = false
                                } label: {
                                    Text("Done")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,160)
                                        .padding(.vertical,12)
                                        .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                        
                                }
                            }
                        }
                    }
                }.padding()
                
            }
            .onDisappear{
                notificationManger.reloadLocalNotifications()
            }
        }
    }
}

