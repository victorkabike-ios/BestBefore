//
//  NewItem.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import SwiftUI

struct NewItem: View {
    @EnvironmentObject var vm: ItemViewModel
    @ObservedObject var notificationManger:NotificationManager
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var category:  [String] = ["Fruits","Vegetables","Dairy"," Meat","Fish & Seafood"," Bread & Bakery"," Frozen Foods","Drink"]
    @State var selectedCategory: String = "Fruits"
    @State var selectedDate  = Date()
    var notificationDate: Date = Date()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    @State var showPicker:Bool = false
    var body: some View {
        NavigationStack{
            ZStack(alignment: .topLeading){
                Color.green.opacity(0.1).ignoresSafeArea()
                    VStack(alignment: .leading){
                        Text("Title")
                        TextField("Bananas", text: $title)
                            .padding(.horizontal)
                            .padding(.vertical,15)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10)
                                )
                        
                        Divider()
                        Text("Category:")
                        Menu{
                            Picker(selection: $selectedCategory, label: EmptyView()) {
                                ForEach(category, id: \.self){ item in
                                    Button {
                                        
                                    } label: {
                                        Text(item)
                                    }
                                    
                                    
                                }
                            }
                        } label: {
                            CustomLabel
                        }
                        Divider()
                        Text("Expiry Date")
                            HStack{
                                Button {
                                    showPicker.toggle()
                                } label: {
                                    HStack{
                                        Image(systemName: "calendar")
                                            .imageScale(.large)
                                            .foregroundColor(.white)
                                            .padding(6)
                                            .background(Color.gray.opacity(0.6), in: Circle())
                                        Text("\(selectedDate, formatter: dateFormatter)")
                                            .foregroundColor(.secondary)
                                        Spacer()
                                    }
                                }.layoutPriority(1)
                                    .buttonStyle(BorderlessButtonStyle())
                                
                            }
                            .padding(.vertical,12)
                            .padding(.horizontal)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
                            .sheet(isPresented: $showPicker) {
                                NavigationView {
                                    VStack {
                                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                            .labelsHidden()
                                            .datePickerStyle(GraphicalDatePickerStyle())
                                            .padding()
                                    }
                                    .navigationBarTitle(Text("Select Date"), displayMode: .inline)
                                    .toolbar {
                                        ToolbarItem(placement: .navigationBarLeading) {
                                            Button("Done") {
                                                showPicker = false
                                            }
                                        }
                                    }
                                    
                                }
                            }
                    }.padding()
                    .navigationTitle("New Item")
                    .navigationBarTitleDisplayMode(.large)
                    .onDisappear{
                        notificationManger.reloadLocalNotifications()
                    }
                    .toolbar {
                        ToolbarItem(placement: .bottomBar){
                            Button {
                                vm.addNewEntity(title: title, category: selectedCategory, expirationDate:selectedDate , notificationDate: notificationDate)
                                notificationManger.scheduleNotification(title: title, expirationDate: selectedDate)
                                dismiss()
                            } label: {
                                Text("Save")
                                    .foregroundColor(.white)
                                    .padding(.horizontal,180)
                                    .padding(.vertical,12)
                                    .background(Color.green, in: RoundedRectangle(cornerRadius: 10))
                                
                            }.padding()

                        }
                        ToolbarItem {
                            Button {
                                dismiss()
                            } label: {
                                Text("Cancel")
                            }

                        }
                    }
                
                        
            }
        }
    }
    @ViewBuilder
    var CustomLabel: some View {
        HStack{
            Image("Fruits")
                .resizable()
                .frame(width: 28,height: 28)
            Text(selectedCategory)
                .foregroundColor(.gray)
            Spacer()
            Text("⌵")
                .foregroundColor(.gray)
                .offset(y: -4)
        }.padding(.horizontal)
            .padding(.vertical,12)
            .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
    }
}
