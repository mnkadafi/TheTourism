//
//  DetailView.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import Core
import Destination
import SDWebImageSwiftUI

struct DetailView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var showingAlert = false
  @ObservedObject var presenter: GetDetailPresenter<
    Any, DestinationDomainModel, Interactor<
      Any, DestinationDomainModel, GetDetailDestinationRepository<
        GetDestinationLocaleDataSource, GetDestinationRemoteDataSource, DetailDestinationTransformer>>>
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else {
        ZStack {
          GeometryReader { geo in
            ScrollView(.vertical) {
              VStack {
                self.imageCategory
                  .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                  .frame(width: geo.size.width, height: 270)
                
                self.content
                  .padding()
              }
            }
          }
          .edgesIgnoringSafeArea(.all)
          .padding(.bottom, 80)
          
          VStack {
            Spacer()
            favorite
              .padding(EdgeInsets.init(top: 0, leading: 16, bottom: 10, trailing: 16))
          }
        }
        
      }
    }
    .onAppear {
      self.presenter.isFavoriteDestination(request: self.presenter.detailDestination as Any)
    }
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: btnBack)
  }
}

extension DetailView {
  var btnBack : some View { Button(action: {
    self.presentationMode.wrappedValue.dismiss()
  }) {
    HStack {
      Image(systemName: "arrow.left.circle.fill")
        .aspectRatio(contentMode: .fill)
        .foregroundColor(.black)
      Text("Back")
        .foregroundColor(.black)
    }
   }
  }
  
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var imageCategory: some View {
    WebImage(url: URL(string: self.presenter.detailDestination!.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .aspectRatio(contentMode: .fill)
      .frame(width: UIScreen.main.bounds.width, height: 270, alignment: .center)
      .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
  }
  
  var header: some View {
    VStack(alignment: .leading) {
      Text("\(self.presenter.detailDestination!.like) Peoples Like This")
        .padding(.bottom, 10)
      
      Text(self.presenter.detailDestination!.name)
        .font(.largeTitle)
        .bold()
        .padding(.bottom, 5)
      
      Text(self.presenter.detailDestination!.address)
        .font(.system(size: 18))
        .bold()
      
      Text("Coordinate: \(self.presenter.detailDestination!.longitude), \(self.presenter.detailDestination!.latitude)")
        .font(.system(size: 13))
    }
  }
  
  var favorite: some View {
    Button(action: {
      if self.presenter.isFavorite {
        self.presenter.removeFavoriteDestination(request: self.presenter.detailDestination as Any)
        self.presenter.isFavoriteDestination(request: self.presenter.detailDestination as Any)
      } else {
        self.presenter.addToFavoriteDestination(request: self.presenter.detailDestination as Any)
        self.presenter.isFavoriteDestination(request: self.presenter.detailDestination as Any)
      }
      
      self.showingAlert.toggle()
    }) {
      if self.presenter.isFavorite {
        Text("Remove From Favorite")
          .font(.system(size: 20))
          .bold()
      } else {
        Text("Add To Favorite")
          .font(.system(size: 20))
          .bold()
      }
    }
    .alert(isPresented: $showingAlert) {
      if self.presenter.isFavorite {
        return Alert(title: Text("Info"), message: Text("Destination Has Added"), dismissButton: .default(Text("Ok")))
      } else {
        return Alert(title: Text("Info"), message: Text("Destination Has Removed"), dismissButton: .default(Text("Ok")))
      }
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
    .buttonStyle(PlainButtonStyle())
    .foregroundColor(Color.white)
    .background(Color.red)
    .cornerRadius(12)
  }
  
  var description: some View {
    VStack(alignment: .leading) {
      Text("Description")
        .font(.system(size: 17))
        .bold()
        .padding(.bottom, 7)
      
      Text(self.presenter.detailDestination!.placeDescription)
        .font(.system(size: 15))
        .multilineTextAlignment(.leading)
        .lineLimit(nil)
        .lineSpacing(5)
    }
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      header
        .padding(.bottom)
      description
    }
  }
}
