import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MBProgressHUD

class DetailViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var detailOneLabel: UILabel!
    @IBOutlet weak var detailTwoLabel: UILabel!
    @IBOutlet weak var detailThreeLabel: UILabel!
    @IBOutlet weak var detailFourLabel: UILabel!
    
    // MARK: - Properties
    var hudProgress: MBProgressHUD?
    
    var item: SearchProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Product"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupView()
    }
    
    func bindView(id: String) {
        showLoading()
    }
    
    func setupView() {
        if let product = item {
            let defaultImage = UIImage(named: Constants.Image.defaultImage)
            let url = URL(string: product.thumbnail)
            
            productImageView.sd_setImage(with: url, placeholderImage: defaultImage)
            titleLabel.text = product.title
            detailOneLabel.text = product.id
            detailTwoLabel.text = product.currencyID
            detailThreeLabel.text = "\(String(describing: product.price))"
            detailFourLabel.text = product.officialStoreName
        }
    }
    
    func showLoading() {
        hudProgress = MBProgressHUD.showAdded(to: self.view, animated: true)
        hudProgress?.label.text = Constants.Text.loading
        hudProgress?.backgroundColor = UIColor(white: 1, alpha: 0.95)
    }
    
    func hideLoading() {
        hudProgress?.hide(animated: true)
    }
}
