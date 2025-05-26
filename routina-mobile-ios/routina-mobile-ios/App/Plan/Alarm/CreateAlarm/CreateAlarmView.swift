//
//  CreateAlarmView.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/27/25.
//

import SwiftUI

struct CreateAlarmView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
                
        }
    }
}

#Preview {
    NavigationStack {
        CreateAlarmView(viewModel: AlarmViewModel())
    }
}
