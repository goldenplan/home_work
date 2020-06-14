//
//  SliderView.swift
//  TVOS
//
//  Created by Stanislav Belsky on 6/10/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

struct SliderView: UIViewRepresentable {
    
    class Coordinator: NSObject, SliderDelegate {
        
        private var sliderView: SliderView

        fileprivate init(_ sliderView: SliderView) {
            self.sliderView = sliderView
            
            super.init()
        }
        
        func sliderDidTap(_ slider: Slider) {
            sliderView.didSelectValue(slider.value)
        }
        
        func slider(_ slider: Slider, didChangeValue value: Double) {
            sliderView.value = value
        }

    }
    
    @Binding private var value: Double
    private let didSelectValue: (Double) -> Void
    
    init(value: Binding<Double>,
         didSelectValue: @escaping (Double) -> Void) {
        
        _value = value
        self.didSelectValue = didSelectValue
    }
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    func makeUIView(context: UIViewRepresentableContext<SliderView>) -> Slider {
        
        let slider = Slider(frame: CGRect.zero, context: context)
        
        slider.delegate = context.coordinator
        slider.value = value
        return slider
    }
    
    func updateUIView(_ uiView: Slider, context: UIViewRepresentableContext<SliderView>) {
//        uiView.value = value
    }
    
    typealias UIViewType = Slider
}
