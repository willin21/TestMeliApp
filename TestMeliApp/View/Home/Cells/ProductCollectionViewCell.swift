import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(image: String) {
        let defaultImage = UIImage(named: Constants.Image.defaultImage)
        let secureImage = image.asSecureURL()
        
        guard let url = URL(string: secureImage) else {
            print("URL no válida: \(image)")
            productImageView.image = defaultImage
            return
        }
        
        productImageView.sd_setImage(with: url, placeholderImage: defaultImage)
    }

}
