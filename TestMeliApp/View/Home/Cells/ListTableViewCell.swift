import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var isFavorite: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupValues(data: SearchProduct) {
        let defaultImage = UIImage(named: Constants.Image.defaultImage)
        let secureImage = data.thumbnail.asSecureURL()
        
        if let urlImage = URL(string: (secureImage)) {
            productImageView.sd_setImage(with: urlImage, placeholderImage: defaultImage)
        }
        
        titleLabel.text = data.title

        userNameLabel.text = ""
        userNameLabel.textColor = .white
    
        dateLabel.text = ""
        setFavouriteImage(isFavourite: isFavorite)
    }

    func setFavouriteImage(isFavourite: Bool) {
        if isFavourite {
            favoriteImage.image = UIImage(named: Constants.Image.favoriteOn)!.withRenderingMode(.alwaysOriginal)
        }else{
            favoriteImage.image = UIImage(named: Constants.Image.favoriteOff)!.withRenderingMode(.alwaysOriginal)
        }
    }
    
}
