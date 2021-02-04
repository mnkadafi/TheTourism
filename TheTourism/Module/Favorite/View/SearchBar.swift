//
//  SearchBar.swift
//  TheTourism
//
//  Created by Mochamad Nurkhayal Kadafi on 22/01/21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
  
  @Binding var text: String
  var onSearchButtonClicked: (() -> Void)?
  
  class Coordinator: NSObject, UISearchBarDelegate {
    
    let control: SearchBar
    
    init(_ control: SearchBar) {
      self.control = control
    }
    
    func searchBar(
      _ searchBar: UISearchBar,
      textDidChange searchText: String
    ) {
      control.text = searchText
      searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(
      _ searchBar: UISearchBar
    ) {
      control.onSearchButtonClicked?()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchBar.text = ""
      searchBar.resignFirstResponder()
      searchBar.showsCancelButton = false
      searchBar.endEditing(true)
      
      control.text = ""
      control.onSearchButtonClicked?()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.delegate = context.coordinator
    searchBar.placeholder = "Search Destination"
    return searchBar
  }
  
  func updateUIView(
    _ uiView: UISearchBar,
    context: UIViewRepresentableContext<SearchBar>
  ) {
    uiView.text = text
  }
  
}
