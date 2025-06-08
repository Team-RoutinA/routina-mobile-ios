//
//  WelcomeView.swift
//  routina-mobile-ios
//
//  Created by 이재혁 on 6/8/25.
//

import SwiftUI
import Network

struct WelcomeView: View {
    @Binding var isLoggedIn: Bool
    @State private var showLogin = false
    @State private var characterOffset: CGFloat = -200
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("환영합니다!")
                        .font(.PretendardBold36)
                        .foregroundColor(.black)
                    
                    Text("루티나와 함께 활기찬 아침을 시작해보세요.")
                        .font(.PretendardMedium20)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 80)
                .padding(.bottom, 30)
                
                Spacer().frame(height: 116)
                
                Image(.welcomeCharacter)
                    .resizable()
                    .frame(width: 236, height: 355)
                    .offset(x: characterOffset)
                    .animation(.interpolatingSpring(stiffness: 80, damping: 10), value: characterOffset)
                    .padding(.leading, 24)
                
                Spacer().frame(height: 34)
                
                MainButton(
                    text: "지금 바로 시작하기",
                    enable: true
                ) {
                    showLogin = true
                }
                
            }
        }
        .onAppear {
            triggerLocalNetworkAccess()
            characterOffset = 0
        }
        .fullScreenCover(isPresented: $showLogin) {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
    
    func getLocalIPAddress() -> String? {
        var address: String?
        
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
            return nil
        }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET), String(cString: interface.ifa_name) == "en0" {
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                            &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                address = String(cString: hostname)
                break
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
        
    func triggerLocalNetworkAccess() {
        let params = NWParameters.udp
        let connection = NWConnection(host: "172.30.1.34", port: 8000, using: params)
        connection.start(queue: .global())
    }

}

//#Preview {
//    WelcomeView()
//}
