import Foundation

class HomeViewModel {
    var cryptoList: [CryptoModel] = [
        CryptoModel(name: "Bitcoin", symbol: "BTC", price: 63500, priceChange: -2.5, iconName: "bitcoin"),
        CryptoModel(name: "Ethereum", symbol: "ETH", price: 3300, priceChange: +1.2, iconName: "neo")
    ]
}
