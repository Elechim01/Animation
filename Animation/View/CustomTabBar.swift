//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Michele Manniello on 17/08/21.
//

import SwiftUI

struct CustomTabBar: View {
    var animation: Namespace.ID
    
//    Extracting Screen Size and bottom safe area....
    var size : CGSize
    var bottomEdge : CGFloat
    @Binding var currentTab : Tab
    
//    Adding Animation...
    @State var startAnimation: Bool = false
    
    var body: some View {
        HStack(spacing: 0){
//            TabButtons....
//            Iterating Tab Enum....
            ForEach(Tab.allCases,id:\.rawValue ){ tab in
                TabButton(tab: tab, animation: animation, currenTab: $currentTab) { pressedTab in
//                    Updating Tab...
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                        startAnimation = true
//                        currentTab = pressedTab
                    }
//                    After Some delay starting tab Animation...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                            currentTab = pressedTab
                        }
                    }
//                    After Tab Animation finished resetting main animation...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                            startAnimation = false
                        }
                    }
                }
            }
        }
//        custom Elastic Shape..
        .background(
            ZStack{
                let animationOffset : CGFloat = (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdge == 0 ? 26 : 27))
                let offset : CGSize = bottomEdge == 0 ? CGSize(width: animationOffset, height: 31) : CGSize(width: animationOffset, height: 36)
                Rectangle()
                    .fill(Color("Purple"))
                    .frame(width: 45, height: 45)
                    .offset(y: 40)
//                same size as button...
//                Adding two circle to create elastic shape...
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8: 1)
//                trail and error method...
                    .offset(x: offset.width, y: offset.height)
                Circle()
                    .fill(.white)
                    .frame(width: 45, height: 45)
                    .scaleEffect(bottomEdge == 0 ? 0.8: 1)
//                trail and error method...
                    .offset(x: -offset.width, y: offset.height)
            }
                .offset(x: getStartOffset())
                .offset(x: getOffset())
//            Moving to start...
            ,alignment: .leading
        )
        .padding(.horizontal,15)
        .padding(.top,7)
        .padding(.bottom,bottomEdge == 0 ? 23 : bottomEdge)
    }
//    Getting start Offset...
    func getStartOffset() -> CGFloat {
//        padding
        let reduced = (size.width - 30) / 4
//        45 = button size...
        let center = (reduced - 45) / 2
        return center
    }
//    moving lastic shape...
    func getOffset() -> CGFloat {
        let reduced = (size.width - 30) / 4
//        getting index and multiply with that
        let index = Tab.allCases.firstIndex{ checkTab in
            return checkTab == currentTab
        } ?? 0
        return reduced * CGFloat(index)
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
////        checking for small devices...
//            .previewDevice("iPhone 8")
    }
}
struct TabButton: View {
    var tab : Tab
    var animation : Namespace.ID
    @Binding var currenTab : Tab
//    Sending back the result...
    var onTap : (Tab) -> ()
    
    
    var body: some View{
//    since we dont need ripple effect while cliking the button..
//    so we re using Ontap...
        Image(systemName: tab.rawValue)
            .foregroundColor(currenTab == tab ? .white : .gray)
//        Default Frame...
            .frame(width: 45, height: 45)
            .background(
//                Using matched Geometry Circle..
                ZStack{
                    if currenTab == tab{
                        Circle()
                            .fill(Color("Purple"))
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                if currenTab != tab{
                onTap(tab)
                }
            }
    }
}
