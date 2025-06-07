//
//  ContentView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 5/25/25.
//

import SwiftUI

struct RootView: View {
    @State private var selectedTab: Int = 1
    
    init() {
        setupTabAppearance()
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                PlanView()
                    .tabItem {
                        Label("계획", image: "planTab")
                    }
                    .tag(0)
                
                DoView(selectedTab: $selectedTab)
                    .tabItem {
                        Label("홈", image: "doTab")
                    }
                    .tag(1)
                
                SeeView()
                    .tabItem {
                        Label("내 기록", image: "seeTab")
                    }
                    .tag(2)
            }
        }
    }
    
    private func setupTabAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // 비선택 상태 색상
        appearance.stackedLayoutAppearance.normal.iconColor = .gray5
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray5]
        
        // 선택 상태 색상
        appearance.stackedLayoutAppearance.selected.iconColor = .gray9
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.gray9]
        
        appearance.shadowColor = nil
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}


#Preview {
    RootView()
}
