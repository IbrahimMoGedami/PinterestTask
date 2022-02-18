//
//  ProductsCell.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 30/01/2022.
//

import UIKit

protocol ProductsCellView {
    func displayPrice(price: String)
    func displayDescription(description: String)
    func getImageURL(imageURL: URL)
}

class ProductsCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImage: ImageLoader!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        self.shadowDecorate(color:  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    }
    
    override var isSelected: Bool{
        didSet{
            UIView.animate(withDuration: 2.0) {
                self.containerView.transform = self.isSelected ? CGAffineTransform(scaleX: 0.9,y: 0.9) : CGAffineTransform.identity
            }
        }
    }
    
    //MARK:- Events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        let animationOptions: UIView.AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .init(scaleX: 0.96, y: 0.96)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                self.transform = .identity
            }, completion: completion)
        }
    }
}

extension ProductsCell : ProductsCellView{
    
    func displayPrice(price: String) {
        productPrice.text = price
    }
    
    func displayDescription(description: String) {
        productDescription.text = description
    }
    
    func getImageURL(imageURL: URL) {
        productImage.loadImageWithUrl(imageURL)
    }
}
