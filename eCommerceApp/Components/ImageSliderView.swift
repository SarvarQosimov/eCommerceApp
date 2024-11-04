//
//  ImageSliderView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 29/12/23.
//

import SwiftUI

struct ImageSliderView: View {
    @State private var currentIndex = 0
    @State var sliders = ["", ""]
    @State private var isInitiallyAppeared = false
    @State var furnituries: [Furniture] = []
    var cnt = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            let url = URL(string: sliders[currentIndex])
            
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .frame(width: .infinity, height: 150)
                    .scaledToFit()
                    .cornerRadius(15)
            } placeholder: {
                Image(systemName: "house")
            }
            
            HStack {
                ForEach(Array(furnituries.enumerated()), id: \.element.id) { index, item in
                    Circle()
                        .fill(self.currentIndex == index ? Color(Constants.kPrimary) : Color(Constants.kSecondary))
                        .frame(width: 10, height: 10)
                }
            }.padding()
        }.padding()
            .onAppear(perform: {
                if !isInitiallyAppeared {
                    startAnimatingImages()
                    isInitiallyAppeared = true
                }
                
                DataMananger.shared.fetchFurnituries { furnitures in
                    self.furnituries = furnitures
                    getImages()
                }
            })
        
        
    }
    
    func startAnimatingImages(){
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            if currentIndex+1 == furnituries.count {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
    }
    
    func getImages(){
        var collector = [String]()
        
        for furniture in furnituries {
            sliders = []
            
            
            collector.append(furniture.image)
        }
        
        sliders = collector
    }
    
}

struct ImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSliderView(furnituries: [])
    }
}
