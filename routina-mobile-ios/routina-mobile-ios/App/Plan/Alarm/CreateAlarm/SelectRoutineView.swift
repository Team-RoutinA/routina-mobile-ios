//
//  SelectRoutineView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/27/25.
//

import SwiftUI

struct SelectRoutineView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @Environment(\.dismiss) var dismiss
    
    let alarmModel: AlarmModel
    
    @State private var selectedRoutines: [String] = []
    @State private var showSnackBar: Bool = false
    
    private var navigationTitle: String {
        "루틴 선택하기"
    }
    
    private var buttonTitle: String {
        "알람 생성"
    }
    
    var body: some View{
        VStack{
            
        }
    }
}
