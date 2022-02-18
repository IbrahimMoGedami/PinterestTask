//
//  ProductsVC.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import UIKit

protocol ProductProtocol : class {
    func pushViewController(product : ProductData)
    func fireCustomError(msg:String)
    func fetchingDataSuccess()
}

class ProductsVC: UICollectionViewController{
    
    var productPresenter : ProductPresenter!
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = collectionView?.collectionViewLayout as? ProductsLayout {
            layout.delegate = self
        }
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        productPresenter = ProductPresenter(product: self)
        productPresenter.getProductData()
    }
}


//MARK: -  CollectionViewDatasource
extension ProductsVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productPresenter.getProductsCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath as IndexPath) as? ProductsCell {
            productPresenter.configure(cell: cell, for: indexPath.row)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
}

//MARK: -  CollectionViewDelegateFlowLayout
extension ProductsVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    
}

//MARK: -  CollectionViewDelegate
extension ProductsVC  {
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productPresenter.pushToVC(currentIndex: indexPath.row)
    }
    
    /** Animate cell*/
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ProductsCell {
                cell.containerView.transform = .init(scaleX: 0.95, y: 0.95)
                cell.containerView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.5) {
            if let cell = collectionView.cellForItem(at: indexPath) as? ProductsCell {
                cell.containerView.transform = .identity
                cell.containerView.backgroundColor = .clear
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        
            cell.alpha = 0
            UIView.animate(withDuration: 1.0, animations: { cell.alpha = 1 })
            
            let rotationAngleInRadians = 90.0 * CGFloat(.pi/180.0)
            let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians,
                                                              0, 0, 1)
            cell.layer.transform = rotationTransform
            UIView.animate(withDuration: 1.0, animations: { cell.layer.transform =
                CATransform3DIdentity })
            
            
    }
}


extension ProductsVC: ProductsLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
            return CGFloat((productPresenter.product?.data[indexPath.row].image.height)!)
        }
}

extension ProductsVC : ProductProtocol {
    func pushViewController(product: ProductData) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC{
            vc.productData = product
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    func fetchingDataSuccess() {
        collectionView.reloadData()
    }
 
    func pushViewController(index: Int) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC{
            vc.productData = productPresenter.product?.data[index]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func fireCustomError(msg: String) {
        self.showHideAlert(title: "Failed", message: msg, handler: nil)
    }
    
}

