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
    @State  var isAdded: Bool = false

    @State private var foodTitle: String = ""
    
    @State private var isEmoji: Bool = false
    @State private var emojiText: String = ""
    
    @State private var showDatePicker: Bool = false
    @State  private var expiredDate = Date()
    @State private var reminderTime = Date()
    
    @State private var isemojiselected: Bool = false
    @State private var istitleselected: Bool = false
    @State private var isDateSelected: Bool = false
    @State private var isCategorySelected: Bool = false
    @State private var isPerishabilitySelected:Bool = false
    
    @State private var showCategory: Bool = false
    enum Category: String , CaseIterable ,Identifiable {
        case  Fruits,Vegetables,Dairy,Meat,FishandSeafood,BreadAndBakery,FrozenFoods, Drink
        var id: Self { self }
    }
    @State private var selectedCategory:Category = Category.Dairy
    
    @State private var showPerishability: Bool = false
    enum Perishability: String ,CaseIterable ,Identifiable {
        case Low, Medium, High
        var id: Self { self}
    }
    @State private var selectedPerishability = Perishability.Low
    var body: some View {
        NavigationView{
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
                        NavigationView{
                            EmojiTextField(text: $emojiText, placeholder: "Enter emoji", isEmoji: $isEmoji)
                                .padding(.horizontal)
                                .padding(.vertical,15)
                                .background(Color.white, in: RoundedRectangle(cornerRadius: 10)
                                )
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button {
                                            isEmoji = false
                                            isemojiselected.toggle()
                                        } label: {
                                            Text("Done")
                                        }
                                    }
                                }
                    }
                }
                    Text( isemojiselected ? emojiText : "Select Emoji")
                        .foregroundColor(.secondary)
                    
                }.padding()
                Divider()
                HStack{
                    Image(systemName: "note.text.badge.plus")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    TextField("Add New Food ", text: $foodTitle)
                        .onTapGesture {
                            istitleselected.toggle()
                        }
                }.padding()
                Divider()
                HStack{
                    Button {
                        showDatePicker.toggle()
                    } label: {
                        Label(isDateSelected ? "" : "Today", systemImage: "calendar")
                            .foregroundColor(.secondary)
                    }
                    .sheet(isPresented: $showDatePicker) {
                        NavigationView{
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
                                    isDateSelected.toggle()
                                } label: {
                                    Text("Done")
                                        .foregroundColor(.white)
                                        .padding(.horizontal,120)
                                        .padding(.vertical,12)
                                        .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                    
                                }
                                
                                
                            }
                            .padding()
                            
                        }
                    }
                    if isDateSelected{
                        Text(expiredDate.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                                
                            }
                    }}.padding()
                Divider()
                HStack{
                    Button {
                        showCategory.toggle()
                    } label: {
                        Label(isCategorySelected ? "" : "Category", systemImage: "tag.fill")
                            .foregroundColor(.secondary)
                    }
                    .sheet(isPresented: $showCategory) {
                        NavigationView{
                            VStack{
                                Picker("", selection: $selectedCategory) {
                                    ForEach(Category.allCases){ item in
                                        Text(item.rawValue)
                                    }
                                }.pickerStyle(.wheel)
                                Button {
                                    showCategory = false
                                    isCategorySelected.toggle()
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
                    
                    if isCategorySelected {
                        Text(selectedCategory.rawValue)
                            .font(.caption)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                    
                            }
                    }
                }.padding()
                Divider()
                HStack{
                    Button {
                        showPerishability.toggle()
                    } label: {
                        Label(isPerishabilitySelected ? "" : "Perishability", systemImage: "flag.fill")
                            .foregroundColor(.secondary)
                    }
                    .sheet(isPresented: $showPerishability) {
                        NavigationView{
                            VStack{
                                Picker("", selection: $selectedPerishability) {
                                    ForEach(Perishability.allCases){ perishability in
                                        Text(perishability.rawValue)
                                    }
                                }.pickerStyle(.wheel)
                                Button {
                                    showPerishability = false
                                    isPerishabilitySelected.toggle()
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
                    
                    if isPerishabilitySelected{
                        Text(selectedPerishability.rawValue)
                            .font(.caption)
                            .padding(.horizontal,20)
                            .padding(.vertical,10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.2))
                    
                            }
                    }
                }.padding()
                Spacer()
                
                
                
            }
            .onDisappear{
                notificationManger.reloadLocalNotifications()
                vm.savedData()
                vm.fetchData()
            }
            .navigationTitle("Add New Food")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        isAdded.toggle()
                    } label: {
                        Text("Send")
                            .foregroundColor(.white)
                            .padding(.horizontal,140)
                            .padding(.vertical,12)
                            .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                    }
                    .disabled(isAllFilled() ? false : true)
                    .onDisappear {
                        vm.fetchData()
                    }
                    .alert("NewFood  Confirmation", isPresented: $isAdded) {
                        Button {
                            vm.addNewEntity(title: foodTitle, category: selectedCategory.rawValue, expirationDate: expiredDate, notificationDate: expiredDate, perishability: selectedPerishability.rawValue, emoji: emojiText, notificationTime: reminderTime)
                            dismiss()
                        } label: {
                            Text("Confirm")
                        }

                    } message: {
                        Text("You Successfully add a new item")
                    }


                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }



                }
            }
        }
    }
    func isAllFilled() -> Bool {
        var condition = false
        if foodTitle.isEmpty && emojiText.isEmpty{
            if expiredDate <= Date() {
                condition =  false
            }
            condition =  false
        }else {
            condition = true
        }
        return condition
    }
}

