//
//  ProductPresenter.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import Foundation
import CoreData

protocol ProductPresenter {
    func getProductsCount() -> Int
    func viewDidLoad()
    func configure(cell: ProductsCellView, for index: Int)
    func didSelect(row: Int)
    func pushToVC(currentIndex : Int)
    func productImageHeight(row : Int) -> Int?
}

class ProductPresenterImplementation {
    
    weak var productPro : ProductView?
    var product : [ProductData]?
    var coreDataManager : CoreDataManagerProtocol?
    var productInterActor = MainProductInterActor()
    
    init(product : ProductView) {
        self.productPro = product
    }
    
    // Initialize a fetched results controller
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let context = coreDataManager?.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductItem")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "productID", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context ?? NSManagedObjectContext(), sectionNameKeyPath: #keyPath(ProductItem.productID), cacheName: nil)
        return frc
    }()
    
    func getProductData(){
        
        switch Connectivity.isConnectedToInternet() {
          case true:
              ///* network available */
            productInterActor.getProduct { [weak self](product, error) in
                guard let self = self else { return }
               
                if error == nil{
                    
                    if let product = product {
                        self.product = product.data
                        
                        self.coreDataManager?.prepare(dataForSaving: product.data)
                    }
                    self.productPro?.fetchingDataSuccess()
                }
                else{
                    self.productPro?.fireCustomError(msg: error?.localizedDescription ?? "")
                }
            }
          case false:
            localData()
            print("no internet connection")
        }
    }
    
}

extension ProductPresenterImplementation : ProductPresenter{
  
    func productImageHeight(row: Int) -> Int? {
        return (product?[row].image?.height)
    }
    
    func viewDidLoad() {
        getProductData()
    }
    
    func didSelect(row: Int) {
        
    }
    
    func getProductsCount() -> Int {
        guard let count = product?.count else { return 0 }
        return count
    }
    
    func configure(cell: ProductsCellView, for index: Int){
        cell.displayDescription(description: product?[index].productDescription ?? "")
        cell.displayPrice(price: "\(product?[index].price ?? 0)")
        if let strUrl = product?[index].image?.url?.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imageUrl = URL(string: strUrl) {
            cell.getImageURL(imageURL: imageUrl)
        }
    }
    
    func pushToVC(currentIndex : Int) {
        guard let product = self.product?[currentIndex] else {return}
        productPro?.pushViewController(product: product)
    }
}


//MARK: Presenter & CoreData
extension ProductPresenterImplementation {
    
    func localData(){
        print("here ya ama")
        guard let data = coreDataManager?.getProductsItem() else {return}
        
        product = data
        for i in data {
            print(i)
        }
    }
}
