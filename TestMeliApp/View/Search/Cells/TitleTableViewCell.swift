import UIKit

class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupValues(text: String) {
        titleLabel.text = text
    }
    
}
