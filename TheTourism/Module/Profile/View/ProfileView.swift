//
//  ProfileView.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 10/12/20.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import User

struct ProfileView: View {
  @ObservedObject var presenter: GetUserPresenter<
    Any, UserDomainModel, Interactor<
      Any, UserDomainModel, GetUserRepository<GetUserLocaleDataSource, UserTransformer>>>
  
  var body: some View {
    VStack {
      ScrollView(.vertical) {
        contentTop
        contentBottom
      }
      .edgesIgnoringSafeArea(.all)
    }
    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    .navigationBarTitle(
      Text("Profile"),
      displayMode: .automatic
    )
  }
}

extension ProfileView {
  var background: some View {
    Image("bg2")
      .resizable()
      .transition(.fade(duration: 0.5))
      .background(Color.black)
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 395, alignment: .center)
      .scaledToFill()
  }
  
  var imageProfile: some View {
    Image("pp")
      .resizable()
      .scaledToFit()
      .transition(.fade(duration: 0.5))
      .frame(width: 100, height: 100)
      .background(Color.white)
  }
  
  var identityProfile: some View {
    VStack(alignment: .center, spacing: 10) {
      Text(self.presenter.users!.full_name)
        .font(.system(size: 28))
        .bold()
        .foregroundColor(.white)
        .lineLimit(nil)
        .multilineTextAlignment(.center)
      
      Text(self.presenter.users!.status)
        .font(.system(size: 20))
        .foregroundColor(.white)
    }
  }
  
  var contentTop: some View {
    ZStack {
      background
      
      VStack(alignment: .center, spacing: 30) {
        imageProfile
          .cornerRadius(20)
        identityProfile
      }
      .padding(EdgeInsets.init(top: 50, leading: 16, bottom: 20, trailing: 16))
    }
  }
  
  var aboutContent: some View {
    VStack(alignment: .center, spacing: 20) {
      Text("About Me")
        .font(.system(size: 22))
        .bold()
        .foregroundColor(.black)
      
      Text(self.presenter.users!.bio)
        .font(.system(size: 16))
        .foregroundColor(.black)
      .lineSpacing(5)
      .multilineTextAlignment(.center)
    }
  }
  
  var contentBottom: some View {
    aboutContent
    .padding(EdgeInsets.init(top: 20, leading: 16, bottom: 20, trailing: 16))
  }
}

//struct ProfileView_Previews: PreviewProvider {
//  static var previews: some View {
//    let useCase = Injection.init().provideProfile()
//    let presenter = ProfilePresenter(profileUseCase: useCase)
//    return ProfileView(presenter: presenter)
//    ProfileView(presenter: presenter).previewLayout(.fixed(width: 1136, height: 640))
//  }
//}
