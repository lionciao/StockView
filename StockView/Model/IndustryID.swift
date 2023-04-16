//
//  IndustryID.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation

enum IndustryID: String, Decodable {
    
    case cement = "01"
    case food = "02"
    case plastic = "03"
    case textile = "04"
    case electricalMachinery = "05"
    case electricalCable = "06"
    case chemical = "21"
    case biomedical = "22"
    case glassCeramics = "08"
    case paper = "09"
    case iron = "10"
    case rubber = "11"
    case auto = "12"
    case semiconductor = "24"
    case computer = "25"
    case optoelectronics = "26"
    case communication = "27"
    case electronicComponents = "28"
    case electronicDistribution = "29"
    case informationServices = "30"
    case otherElectronics = "31"
    case buildingMaterials = "14"
    case shipping = "15"
    case tourism = "16"
    case financial = "17"
    case trade = "18"
    case electricGas = "23"
    case general = "19"
    case other = "20"
    case manageStocks = "80"
}

extension IndustryID {
    
    var name: String {
        switch self {
        case .cement: return "水泥工業"
        case .food: return "食品工業"
        case .plastic: return "塑膠工業"
        case .textile: return "紡織工業"
        case .electricalMachinery: return "電機機械"
        case .electricalCable: return "電器電纜"
        case .chemical: return "化學工業"
        case .biomedical: return "生技醫療"
        case .glassCeramics: return "玻璃陶瓷"
        case .paper: return "造紙工業"
        case .iron: return "鋼鐵工業"
        case .rubber: return "橡膠工業"
        case .auto: return "汽車工業"
        case .semiconductor: return "半導體業"
        case .computer: return "電腦及週邊設備業"
        case .optoelectronics: return "光電業"
        case .communication: return "通訊網路業"
        case .electronicComponents: return "電子零組件業"
        case .electronicDistribution: return "電子通路業"
        case .informationServices: return "資訊服務業"
        case .otherElectronics: return "其他電子業"
        case .buildingMaterials: return "建材營造業"
        case .shipping: return "航運"
        case .tourism: return "觀光"
        case .financial: return "金融"
        case .trade: return "貿易百貨"
        case .electricGas: return "油電燃氣"
        case .general: return "綜合"
        case .other: return "其他"
        case .manageStocks: return "管理股票（由櫃買中心管理）"
        }
    }
}

extension IndustryID: Hashable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
