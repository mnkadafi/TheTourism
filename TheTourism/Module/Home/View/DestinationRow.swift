//
//  DestinationRow.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Destination

struct DestinationRow: View {
  
  var destination: DestinationDomainModel
  
  var body: some View {
    ZStack(alignment: .bottomLeading) {
      imageDestination
      content
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 270)
  }
}

extension DestinationRow {
  
  var imageDestination: some View {
    WebImage(url: URL(string: destination.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .frame(width: UIScreen.main.bounds.width - 32)
      .cornerRadius(15)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(destination.name)
        .font(.title)
        .foregroundColor(Color.white)
      .bold()
      
      Text(destination.address)
        .font(.body)
        .foregroundColor(Color.white)
    }.padding(EdgeInsets(top: 0,
                         leading: 16,
                         bottom: 16,
                         trailing: 16))
  }
  
}

struct DestinationRow_Previews: PreviewProvider {
  static var previews: some View {
    let imageUrl = "https://images.unsplash.com/" +
      "photo-1505993597083-3bd19fb75e57?ixlib=rb-1.2.1&ixid=" +
      "eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1354&q=80"
    
    let destination = DestinationDomainModel(
      id: 1,
      name: "Gunung Bromo",
      description: """
Gunung Bromo (dari bahasa Sanskerta:
Brahma, salah seorang Dewa Utama dalam agama Hindu)
atau dalam bahasa Tengger dieja \"Brama\", adalah sebuah gunung berapi aktif di Jawa Timur, Indonesia.
""",
      address: "Podokoyo, Tosari, Pasuruan",
      longitude: 112.9355026,
      latitude: -7.9424931,
      like: 100,
      image: imageUrl,
      isFavorite: true)
    
    return DestinationRow(destination: destination)
  }
}
