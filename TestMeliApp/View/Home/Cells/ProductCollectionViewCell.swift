import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(image: String) {
        let defaultImage = UIImage(named: Constants.Image.defaultImage)
        let url = URL(string: image)
        
        productImageView.sd_setImage(with: url, placeholderImage: defaultImage)
    }

}
