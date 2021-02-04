//
//  FavoriteRow.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Destination

struct FavoriteRow: View {
  
  var destination: DestinationDomainModel
  
  var body: some View {
    HStack {
      imageDestination
        .padding(.leading)
        .padding(.trailing, 10)
      content
        .padding(.trailing)
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 130, alignment: .leading)
    .background(Color(red: 245/255, green: 245/255, blue: 245/255))
    .cornerRadius(10)
  }
}

extension FavoriteRow {
  
  var imageDestination: some View {
    WebImage(url: URL(string: destination.image))
      .resizable()
      .indicator(.activity)
      .scaledToFill()
      .transition(.fade(duration: 0.5))
      .frame(width: 110, height: 90)
      .cornerRadius(10)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(destination.name)
        .font(.system(size: 22))
        .foregroundColor(Color.black)
        .bold()
      
      Text(destination.address)
        .font(.system(size: 17))
        .foregroundColor(Color.black)
    }
  }
  
}

//struct FavoriteRow_Previews: PreviewProvider {
//  static var previews: some View {
//    let imageUrl = "https://images.unsplash.com/" + "photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid" +
//    "=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
//    
//    let destination = DestinationModel(
//      id: 1,
//      name: "Gunung Bromo",
//      placeDescription: """
//    Gunung Bromo (dari bahasa Sanskerta:
//    Brahma, salah seorang Dewa Utama dalam agama Hindu)
//    atau dalam bahasa Tengger dieja \"Brama\"
//    """,
//      address: "Podokoyo, Tosari, Pasuruan",
//      longitude: 112.9355026,
//      latitude: -7.9424931,
//      like: 100,
//      image: imageUrl,
//      isFavorite: true)
//    
//    return FavoriteRow(destination: destination).previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
//  }
//}
