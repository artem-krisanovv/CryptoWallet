import Foundation

struct CoinAPI {
    let url = URL(string: "https://data.messari.io/api/v1/assets")!
    let allowedCoins = ["btc", "eth", "trx", "luna", "dot", "doge", "usdt", "xlm", "ada", "xrp"]
}
