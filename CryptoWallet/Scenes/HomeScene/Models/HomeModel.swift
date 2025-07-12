import Foundation

struct AssetsResponse: Codable {
    let data: [Crypto]
}

struct Crypto: Codable {
    let id: String
    let symbol: String
    let name: String
    let metrics: Metrics?
}

struct Metrics: Codable {
    let marketData: MarketData?

    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let percentChangeUsdLast24Hours: Double?
    let marketCapUsd: Double?
    let circulatingSupply: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
        case marketCapUsd = "market_cap_usd"
        case circulatingSupply = "circulating_supply"
    }
}
