//
//  ViewTypes.swift
//  work_11
//
//  Created by Stanislav Belsky on 5/31/20.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import SwiftUI

enum ViewTypes: String, Codable, CaseIterable {

    case HomeViewType
    case ConfigViewType
    case SplashViewType
    case PinEnterViewType
    case ErrorViewType
    
    static let startable = [HomeViewType, ConfigViewType]

    private enum CodingKeys: String, CodingKey {
        
        case HomeViewType
        case ConfigViewType
    }

    enum PostTypeCodingError: Error {
        case decoding(String)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let _ = try? values.decode(String.self, forKey: .HomeViewType) {
            self = .HomeViewType
            return
        }

        if let _ = try? values.decode(String.self, forKey: .ConfigViewType) {
            self = .ConfigViewType
            return
        }
        throw PostTypeCodingError.decoding("Whoops! \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .HomeViewType:
            try container.encode("", forKey: .HomeViewType)
        case .ConfigViewType:
            try container.encode("", forKey: .ConfigViewType)
        default:
            break
        }
    }

    func getView() -> AnyView{
        switch self {
        case .HomeViewType:
            return AnyView(HomeView())
        case .ConfigViewType:
            return AnyView(ConfigView().environmentObject(ConfigViewModel()))
        case .SplashViewType:
            return AnyView(SplashView())
        case .PinEnterViewType:
            return AnyView(PinEnterView())
        case .ErrorViewType:
            return AnyView(ErrorView())
        }
    }
    
}
