//
//  TopTabBar.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct TopTabBar: View {
    @Binding var selectedTab: String
    private let tabs = ["알람", "루틴"]
    @Namespace private var indicatorNamespace

    var body: some View {
        HStack(spacing: 40) {
            ForEach(tabs, id: \.self) { tab in
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        Text(tab)
                            .font(.routina(.h2))
                            .foregroundColor(selectedTab == tab ? .black : .gray6)
                            .background(
                                ZStack {
                                    if selectedTab == tab {
                                        Rectangle()
                                            .fill(Color.black)
                                            .frame(height: 2)
                                            .offset(y: 22)
                                            .matchedGeometryEffect(id: "underline", in: indicatorNamespace)
                                    }
                                }
                            )
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 12)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}
