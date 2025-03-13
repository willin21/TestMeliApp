import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(text: String) {
        commentTextView.text = text
    }
    
}
