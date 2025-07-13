import Foundation

class HomeViewModel {
    
    private(set) var cryptoList: [Crypto] = []
    private(set) var isLoading: Bool = false
    
    var onUpdate: (() -> Void)?

    // MARK: - Loading Data

    func loadAssets() {
        isLoading = true
        onUpdate?()
        NetworkService.shared.fetchAssets { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let assets):
                    self?.cryptoList = assets
                case .failure:
                    self?.cryptoList = []
                }
                self?.onUpdate?()
            }
        }
    }

    // MARK: - Sort

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



