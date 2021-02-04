//
//  CustomInformationView.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/01/21.
//

import SwiftUI

struct CustomInformationView: View {
  var symbolName: String = ""
  var text: String = ""
  
  var body: some View {
    contentInformation
  }
  
  var imageInformation: some View {
    Image(systemName: symbolName)
      .resizable()
      .foregroundColor(Color.systemGray)
      .frame(width: 150, height: 150, alignment: .center)
  }
  var informationText: some View {
    Text(text)
      .font(.subheadline)
      .multilineTextAlignment(.center)
      .foregroundColor(Color.systemGray)
      .frame(width: UIScreen.main.bounds.width - 64, height: 60)
  }
  
  var contentInformation: some View {
    VStack(alignment: .center) {
      imageInformation
        .padding(.top, 100)
      informationText
    }
    .padding([.leading, .trailing], 16)
  }
}
