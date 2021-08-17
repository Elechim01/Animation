//
//  Home.swift
//  Home
//
//  Created by Michele Manniello on 17/08/21.
//

import SwiftUI

struct Home: View {
//    Current Tab...
    @State var currentTab : Tab = .Home
    
//    Hiding native One...
    init(size : CGSize, bottomEdge : CGFloat){
        self.size = size
        self.bottomEdge = bottomEdge
        UITabBar.appearance().isHidden = true
    }
    
//    For Matched Geometry Effect...
    @Namespace var animation
    var size : CGSize
    var bottomEdge: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
//            Natie Tab View...
            TabView(selection: $currentTab) {
//                Tab views..
                Text("Home")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.Home)
                Text("Search")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.Search)
                Text("Liked")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.Liked)
                Text("Settings")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.04).ignoresSafeArea())
                    .tag(Tab.Settings)
                
            }
//            Custom Tab Bar
            CustomTabBar(animation: animation,size: size,bottomEdge: bottomEdge,currentTab: $currentTab)
                .background(Color.white)
        } 
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
enum Tab: String,CaseIterable {
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Liked = "suit.heart.fill"
    case Settings = "gearshape"
}
