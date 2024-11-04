//
//  ProfilePageView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 25/01/24.
//

import SwiftUI
import MapKit

struct ProfilePageView: View {
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State var showAppThemView = false
    @State var showContactUsView = false
    @State var showEditView = true
    
    @Binding var isAppThemChanged: Bool
    @Binding var hideTabbar: Bool
    @State var updateView = false
    
    @ObservedObject var locationMananger = LocationMananger()
    @ObservedObject var profilePageVM = ProfilePageVM()

    @AppStorage("userImage") var userImageData: Data?
    @AppStorage("userName") var userName = "Ismingiz"
    @AppStorage("userEmail") var userGmail = ""
    @AppStorage("homeAdress") var homeAdress = ""
    @AppStorage("appThem") var appThem = AppThem.auto.rawValue
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        
                        UserInfoSectionView()
                        
                        Spacer()
                    }
                    .background(TopGradientColor())
                    
                    VStack(spacing: 33) {
                        HStack(spacing: 15) {
                            ContactAndAppThemView(image: "connectionIcon", text: "Biz bilan bog`laning", action: {
                                showContactUsView.toggle()
                            })
                            
                            ContactAndAppThemView(image: "appThemIcon", text: "Ilova mavzusi", action: { showAppThemView.toggle() })
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        MapView()
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }
    
    //MARK: - UserImageView
    @ViewBuilder func UserImageView() -> some View {
        HStack(alignment: .top) {
            if let userImageData = userImageData, let image = UIImage(data: userImageData) {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color(Constants.kPrimary))
                        .cornerRadius(75)
                        .padding(.trailing, 55)
                }
            } else {
                HStack(alignment: .center) {
                    Spacer()
                    
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .foregroundColor(Color(Constants.kPrimary))
                        .padding(.trailing, 55)
                }
            }
            
            Spacer()
                
            NavigationLink(value: "a") {
                Image("settingsIcon")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .cornerRadius(9)
                    .padding(.trailing, 25)
                    .onTapGesture {
                        hideTabbar = true
                    }
            }
            .navigationDestination(isPresented: $hideTabbar) {
                EditPofileView()
            }
                
            
            
           
        }
    }
    
    //MARK: - UserInfoSectionView
    @ViewBuilder func UserInfoSectionView() -> some View {
        VStack(alignment: .center) {
            UserImageView()
            
            Text(userName)
                .font(.custom(Constants.mainFont, size: 25))
            
            Text(userGmail)
                .font(.footnote)
                .bold()
        }
        .padding(.leading)
        .padding(.bottom)
    }
    
    //MARK: - ContactAndAppThemView
    @ViewBuilder func ContactAndAppThemView(image: String, text: String, action: @escaping ( () -> Void )) -> some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 39)
                .foregroundStyle(Color.ColorByAppThemColor(.white))
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 11))
            
            Text(text)
                .foregroundStyle(Color.ColorByAppThemColor(.white))
                .bold()
        }
        .frame(width: 175, height: 95)
        .background(Color.ColorByAppThemColor(.primary))
        .cornerRadius(15)
        .onTapGesture {
            action()
        }
        .sheet(isPresented: $showAppThemView, content: {
            CustomMiniSheet(title: "Ilova mavzusini tanlang", buttons: [
                CustomMiniSheetButton(
                    buttonImage: "sun.min.fill", buttonTitle: "Yorug` rejim",
                    isSelected: appThem == "light",
                    action: {
                        appThem = "light"
                    }),
                CustomMiniSheetButton(
                    buttonImage: "moon.fill", buttonTitle: "Qorong`u rejim",
                    isSelected: appThem == "dark",
                    action: { appThem = "dark"}
                ),
                CustomMiniSheetButton(
                    buttonImage: "iphone.gen2", buttonTitle: "Avtomatik",
                    isSelected: appThem == "auto",
                    action: { appThem = "auto" })
            ], isDismissed: $showAppThemView)
            .presentationDetents([.height(263)])
        })
        .sheet(isPresented: $showContactUsView, content: {
            CustomMiniSheet(title: "Bog`lanish turini tanlang", buttons: [
                CustomMiniSheetButton(
                    buttonImage: "phone.fill", buttonTitle: "Telefon orqali", action: {
                        profilePageVM.openPhoneCall("+998998158022")
                    }),
                CustomMiniSheetButton(
                    buttonImage: "ellipsis.message", buttonTitle: "Xabar orqali", action: {
                        profilePageVM.openTelegramApp("SarvarQosimov2003")
                    })
            ], isDismissed: $showContactUsView)
            .presentationDetents([.height(225)])
        })
        .onChange(of: showAppThemView, perform: { value in
            if !value {
                isAppThemChanged = true
            }
        })
    }
    
    //MARK: - MapView
    @ViewBuilder func MapView() -> some View {
        VStack {
            Map(
                coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: nil
            )
            .onAppear(perform: {
                setUserCurrentLocation()
            })
            .frame(height: 150)
            .cornerRadius(33)
            .padding(.horizontal)
            
            HStack {
                Spacer()
                
                Text("Yetkazib berish manzili")
                    .foregroundStyle(Color.ColorByAppThemColor(.black))
            }
            .padding(.trailing)
        }

    }
    
    //MARK: - TopGradientColor
    @ViewBuilder func TopGradientColor() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(Constants.kSecondary), Color(Constants.kPrimary).opacity(0.5)
            ]),
            startPoint: .topLeading,
            endPoint: .topTrailing
        )
        //        .frame(height: 300)
        .ignoresSafeArea(edges: .top)
    }
    
    //MARK: - functions
    
    private func setUserCurrentLocation(){
        let latitude = locationMananger.location?.coordinate.latitude ?? 37.7749
        let longitude = locationMananger.location?.coordinate.longitude ?? -122.4194
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: latitude, longitude: longitude
            ),
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
    }
    
}

#Preview {
    ProfilePageView(isAppThemChanged: .constant(false), hideTabbar: .constant(false))
}

