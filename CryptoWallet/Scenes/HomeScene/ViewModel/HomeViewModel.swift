import Foundation

class HomeViewModel {
    private(set) var cryptoList: [Crypto] = []
    private let networkService = NetworkService()
    
    var onUpdate: (() -> Void)?
    var isLoading: Bool = false
    var onError: (() -> Void)?
    
    private let allowedCoins = ["btc", "eth", "trx", "luna", "dot", "doge", "usdt", "xlm", "ada", "xrp"]
    
    func loadAssets() {
        isLoading = true
        onUpdate?()
        networkService.fetchAssets { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let allAssets):
                let filtered = allAssets.filter { self?.allowedCoins.contains($0.symbol.lowercased()) ?? false }
                self?.cryptoList = filtered
                self?.onUpdate?()
            case .failure(_):
                self?.onError?()
                self?.onUpdate?()
            }
        }
    }
    
    // MARK: - Sort Func
    
    enum SortOrder {
        case priceChangeAsc
        case priceChangeDesc
    }
    
    func sort(by order: SortOrder) {
        switch order {
        case .priceChangeAsc:
            cryptoList.sort {
                ($0.metrics?.marketData?.percentChangeUsdLast24Hours ?? 0) >
                ($1.metrics?.marketData?.percentChangeUsdLast24Hours ?? 0)
            }
        case .priceChangeDesc:
            cryptoList.sort {
                ($0.metrics?.marketData?.percentChangeUsdLast24Hours ?? 0) <
                    ($1.metrics?.marketData?.percentChangeUsdLast24Hours ?? 0)
            }
        }
        onUpdate?()
    }
}



