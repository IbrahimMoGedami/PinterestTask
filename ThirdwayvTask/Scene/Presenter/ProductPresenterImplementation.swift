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
    func productImageHeight(row : Int) -> Int
}

class ProductPresenterImplementation {
    
    weak var productPro : ProductView?
    var product : Product?
    var coreDataManager : CoreDataManagerProtocol?
    var productInterActor = MainProductInterActor()
    
    init(product : ProductView) {
        self.productPro = product
    }
    
    // Initialize a fetched results controller
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let context = coreDataManager?.managedObjectContext
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
                        self.product = product
                        for i in product.data{
                            self.coreDataManager?.prepare(dataForSaving: [i])
                            print(i)
                        }
                    }
                    self.productPro?.fetchingDataSuccess()
                }
                else{
                    self.productPro?.fireCustomError(msg: error?.localizedDescription ?? "")
                }
            }
          case false:
//              getDataFromCoreData()
            print("no internet connection")
        }
    }
    
}

extension ProductPresenterImplementation : ProductPresenter{
    
    func productImageHeight(row: Int) -> Int {
        return (product?.data[row].image.height)!
    }
    
    func viewDidLoad() {
        getProductData()
    }
    
    func didSelect(row: Int) {
        
    }
    
    func getProductsCount() -> Int {
        guard let count = product?.data.count else { return 0 }
        return count
    }
    
    func configure(cell: ProductsCellView, for index: Int){
        cell.displayDescription(description: product?.data[index].productDescription ?? "")
        cell.displayPrice(price: "\(product?.data[index].price ?? 0)")
        if let strUrl = product?.data[index].image.url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imageUrl = URL(string: strUrl) {
            cell.getImageURL(imageURL: imageUrl)
        }
    }
    
    func pushToVC(currentIndex : Int) {
        guard let product = self.product?.data[currentIndex] else {return}
        productPro?.pushViewController(product: product)
    }
}


//MARK: Presenter & CoreData
extension ProductPresenterImplementation {
    
    func getDataFromCoreData(index: IndexPath){
        
        do{
            try fetchedResultsController.performFetch()
        }catch(let ex){
            
            print(ex.localizedDescription)
        }
        
        self.product?.data[index.row] = fetchedResultsController.object(at: index)
        
    }
    
}
