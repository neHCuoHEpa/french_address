//
//  SearchView.swift
//  FrenchAdress
//
//  Created by Slav Sarafski on 2.10.23.
//

import SwiftUI
import _MapKit_SwiftUI

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    
    var body: some View {
        VStack {
            SearchBox()
            MapView()
        }
        .ignoresSafeArea(edges: .bottom)
        .environmentObject(searchViewModel)
        .onChange(of: searchViewModel.selectedAddress, perform: searchViewModel.calculateRegion)
    }
    
    
}

struct SearchBox: View {
    
    @EnvironmentObject var searchViewModel: SearchViewModel
    
    var body: some View {
        VStack {
            TextField("Search", text: $searchViewModel.searchText)
                .foregroundColor(.black)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(8)
                .padding(10)
                .background(Color.cyan)
            
            List(searchViewModel.addresses) { address in
                addressRow(address)
            }
        }
        .onChange(of: searchViewModel.searchText, perform: searchViewModel.search)
    }
    
    func addressRow(_ address: Adress) -> some View {
        Button(action: { self.select(address: address) } ) {
            Text(address.formatted)
                .foregroundColor(.black)
                .font(.system(size: 12))
                .padding(12)
        }
    }
    
    func select(address: Adress) {
        searchViewModel.selectedAddress = address
    }
}

struct MapView: View {
    
    @EnvironmentObject var searchViewModel: SearchViewModel
    
    var body: some View {
        Map(coordinateRegion: .constant(searchViewModel.coordinateRegion),
            showsUserLocation: true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
