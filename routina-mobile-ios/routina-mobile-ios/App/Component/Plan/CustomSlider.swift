//
//  CustomSlider.swift
//  routina-mobile-ios
//
//  Created by 이슬기 on 5/27/25.
//

import SwiftUI

struct CustomSlider: UIViewRepresentable {
    @Binding var value: Float

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)

        // 썸 이미지 커스터마이징
        let thumbImage = UIImage(systemName: "circle.fill")?
            .withTintColor(UIColor(.mainBlue), renderingMode: .alwaysOriginal)
            .resize(to: CGSize(width: 13, height: 13)) // 크기 조절
        slider.setThumbImage(thumbImage, for: .normal)
        
        // 트랙 색상 설정
        slider.minimumTrackTintColor = UIColor(.mainBlue)

        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = value
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }

    class Coordinator: NSObject {
        var value: Binding<Float>
        init(value: Binding<Float>) {
            self.value = value
        }

        @objc func valueChanged(_ sender: UISlider) {
            value.wrappedValue = sender.value
        }
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resized = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resized ?? self
    }
}
