//
//  EditPofileView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 04/02/24.
//

import SwiftUI
import PhotosUI

struct EditPofileView: View {
    @State var selectedItem: [PhotosPickerItem] = []
    @State var data: Data?
    @State var userImage = Image("personForProfile")
    @State var name = ""
    @State var gmail = ""
    @State var adress = ""
    
    @AppStorage("userImage") var userImageData: Data?
    @AppStorage("userName") var userName = ""
    @AppStorage("userEmail") var userGmail = ""
    @AppStorage("homeAdress") var homeAdress = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            VStack {
                CustomBackButtonView(navigationTitle: "Profil")
                
                EditUserImageView()
                
                ZStack {
                    Color.ColorByAppThemView(.systemGram6OrPrimary)
                        .ignoresSafeArea()
                    
                    EditUserInfosSectionView()
                }
                
                SaveButtonView()
            }
            .padding(.bottom, 55)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: selectedItem, perform: { value in
            guard let item = value.first else { return }
            
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        self.data = data
                        userImage = Image(uiImage: ((UIImage(data: data))!))
                    } else {
                        print("data is nil")
                    }
                case .failure(_):
                    print("failure")
                }
            }
        })
        .onAppear {
            //set initial values
            if let userImageData = userImageData {
                userImage = Image(uiImage: UIImage(data: userImageData)!)
            }
            
            data = userImageData
            name = userName
            gmail = userGmail
            adress = homeAdress
        }
        .scrollContentBackground(.hidden)
    }
    
    //MARK: - EditUserImageView
    @ViewBuilder func EditUserInfosSectionView() -> some View {
        Form() {
            Section {
                TextField("Ismingizni kiriting", text: $name)
                    .font(.body)
                    .frame(height: 45)
                
                TextField("Email adressni kiriting", text: $gmail)
                    .frame(height: 45)
                
                TextField("Manzilingizni kiriting", text: $adress)
                    .frame(height: 45)
            } header: {
                Text("Shaxsiy ma`lumotlar")
                    .foregroundStyle(Color.ColorByAppThemColor(.black))
                    .font(.custom(Constants.mainFont, size: 17))
                    .fontWeight(.medium)
            }
            
            Section {
                HStack {
                    Text("Yetkazib berish manzilni qo`lda kiritish")
                    
                    Spacer()
                    
                    Image(systemName: "map.circle")
                        .resizable()
                        .frame(width: 33, height: 33)
                }
                .padding()
            } header: {
                Text("Qo`shimcha ma`lumotlar")
                    .foregroundStyle(Color.ColorByAppThemColor(.black))
                    .font(.custom(Constants.mainFont, size: 17))
                    .fontWeight(.medium)
            }
        }
    }
    
    //MARK: - EditUserInfosSectionView
    @ViewBuilder func EditUserImageView() -> some View {
        userImage
            .resizable()
            .frame(height: 175)
            .clipShape(RoundedRectangle(cornerRadius: 11))
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 33, height: 33)
                        .foregroundStyle(Color.ColorByAppThemColor(.black))
                        .bold()
                        .offset(CGSize(width: 10.0, height: 10.0))
                }
            }
            .padding()
    }
    
    //MARK: - SaveButtonView
    @ViewBuilder func SaveButtonView() -> some View {
        Button {
            userImageData = data
            userName = name
            userGmail = gmail
            homeAdress = adress
            
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Spacer()
                
                Image("saveButtonIcon")
                    .resizable()
                    .frame(width: 33, height: 33)
                    .bold()
                
                Text("Saqlash")
                    .font(.custom(Constants.mainFont, size: 25))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.ColorByAppThemColor(.white))
                
                Spacer()
            }
            .frame(height: 50)
            .background(Color.ColorByAppThemColor(.primary))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            .shadow(color: Color.black.opacity(0.75), radius: 5, x: 5, y: 5)
        }
    }
}

#Preview {
    EditPofileView()
}
