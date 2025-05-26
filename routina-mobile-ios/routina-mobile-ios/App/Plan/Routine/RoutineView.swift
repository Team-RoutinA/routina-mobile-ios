//
//  RoutineListView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/25/25.
//

import SwiftUI

struct RoutineView: View {
    @ObservedObject var viewModel: RoutineViewModel = RoutineViewModel()
    @State private var isPresentingCreateView = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // 안내 텍스트
                    HStack {
                        Text("루틴을 만들거나 수정해 보세요")
                            .font(.routina(.h2))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    // 루틴 생성 버튼
                    CreateRoutineButton(text: "루틴 생성하기") {
                        print("루틴 생성 버튼 눌림")
                        isPresentingCreateView = true
                    }
                    .padding(.horizontal, 24)
                    
                    // 루틴 리스트 박스
                    VStack(spacing: 0) {
                        ForEach(viewModel.routines.indices, id: \.self) { i in
                            RoutineSelectRow(
                                iconName: viewModel.routines[i].icon,
                                title: viewModel.routines[i].title,
                                subtitle: nil,
                                showChevron: true,
                                isPlaceholder: false,
                                onTap: {
                                    print("루틴 \(i) 선택됨")
                                }
                            )
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                    .padding(.top, 4)
                }
                .padding(.top, 20)
            }
            .background(Color.gray1.ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $isPresentingCreateView) {
            NavigationStack {
                CreateRoutineView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    RoutineView()
}
