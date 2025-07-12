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
    let percentChangeUsdLast1Hour: Double?
    let percentChangeUsdLast7Days: Double?
    let percentChangeUsdLast30Days: Double?
    let percentChangeUsdLast1Year: Double?
    let marketCapUsd: Double?
    let circulatingSupply: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLast1Hour = "percent_change_usd_last_1_hour"
        case percentChangeUsdLast24Hours = "percent_change_usd_last_24_hours"
        case percentChangeUsdLast7Days = "percent_change_usd_last_7_days"
        case percentChangeUsdLast30Days = "percent_change_usd_last_30_days"
        case percentChangeUsdLast1Year = "percent_change_usd_last_1_year"
        case marketCapUsd = "market_cap_usd"
        case circulatingSupply = "circulating_supply"
    }
}
