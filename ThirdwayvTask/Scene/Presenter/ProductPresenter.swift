//
//  ProductPresenter.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import Foundation

class ProductPresenter{
    
    weak var productPro : ProductProtocol?
    var product : Product?
    var productIntcator = ProductInteractor()
    
    init(product : ProductProtocol) {
        self.productPro = product
    }
    
    func getProductData(){
        productIntcator.productApi { [weak self](product, error) in
            guard let sellf = self else { return }
            if error == nil{
                
                if let product = product {
                    sellf.product = product
                }
                DispatchQueue.main.async {
                    sellf.productPro?.fetchingDataSuccess()
                }
            }else{
                DispatchQueue.main.async {
                    sellf.productPro?.fireCustomError(msg: error?.localizedDescription ?? "")
                }
            }
        }
    }
    func pushToVC(currentIndex : Int) {
        guard let product = self.product?.data[currentIndex] else {return}
        productPro?.pushViewController(product: product)
    }
    
    func getProductsCount() -> Int {
        guard let count = product?.data.count else { return 0 }
        return count
    }
    
    func configure(cell: ProductsCellView, for index: Int){
        cell.displayDescription(description: product?.data[index].productDescription ?? "")
        cell.displayPrice(price: "\(product?.data[index].price ?? 0)")
        if let strUrl = product?.data[index].image.url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let imgUrl = URL(string: strUrl) {
            cell.getImageURL(imageURL: imgUrl)
        }
    }
    
}
