//
//  ProductsVC.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//
//
//-->https://mocki.io/v1/66582140-ff28-4ab4-a9f7-adaa2e494417
import UIKit

protocol ProductView : class {
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
        productPresenter = ProductPresenterImplementation(product: self)
        productPresenter.viewDidLoad()
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
            cell.delegate = self
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
        
            self.productPresenter.pushToVC(currentIndex: indexPath.row)
        
//       let cell = collectionView.cellForItem(at: indexPath) as! ProductsCell
//        cell.superview?.bringSubviewToFront(cell)
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, animations: {
//            cell.frame = collectionView.bounds
//            collectionView.isScrollEnabled = false
////            let backBu = cell.viewWithTag(1) as! UIButton
//            cell.backButton.isHidden = false
//            cell.delegate = self
////            backBu.addTarget(self, action: #selector(self.backBuTaped), for: .touchUpInside)
//        }, completion: nil)
        
        
        //
        //        let cell = collectionView.cellForItem(at: indexPath)
        //        UIView.animate(withDuration: 0.2,animations: {
        //            cell?.alpha = 0.5
        //        }) {[weak self] (completed) in
        //            //fade in
        //            UIView.animate(withDuration: 0.2,animations: {
        //                //Fade out
        //                guard let self = self else {return}
        //                cell?.alpha = 1
        ////                self.productPresenter.pushToVC(currentIndex: indexPath.row)
        //            })
        //        }
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //MARK: Animation 1
        //        let rotationtransForm = CATransform3DTranslate(CATransform3DIdentity, 0, -10,0)
        //        cell.layer.transform = rotationtransForm
        //        cell.alpha = 0
        //        UIView.animate(withDuration: 1.0) {
        //            cell.layer.transform = CATransform3DIdentity
        //            cell.layer.transform = CATransform3DIdentity
        //            cell.alpha = 1
        //        }
        
        //MARK: Animation 2
        let animationDuration: Double = 0.5
        let delayBase: Double = 0.1
        cell.alpha = 0
        let delay = sqrt(Double(indexPath.row)) * delayBase
        UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseOut, animations: {
            cell.alpha = 1
        })
    }
}


extension ProductsVC: ProductsLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
            return CGFloat(productPresenter.productImageHeight(row: indexPath.row) ?? 0)
        }
}

extension ProductsVC : ProductView {
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
    
    func fireCustomError(msg: String) {

        Alert.showAlert(title: "Failed", message: msg)
    }
    
}

extension ProductsVC : BackBuDidTapped{
    func backBuTapped() {
        collectionView.isScrollEnabled = true
        let indexPath = collectionView.indexPathsForSelectedItems!
        collectionView.reloadItems(at: indexPath)
        print("selected")
    }
}
