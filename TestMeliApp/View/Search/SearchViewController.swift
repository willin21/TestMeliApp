import UIKit

private struct Cells {
    static let titleTableViewCell = "TitleTableViewCell"
}

class SearchViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!

    // MARK: - Properties
    private var lastKeyWordTyped: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigation()
    }
    
    private func setupView() {
        searchTextField.delegate = self
        
        searchTableView.register(UINib(nibName: Cells.titleTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.titleTableViewCell)
        
        searchTextField.placeholder = "Search..."
    }
    
    private func fetchRequest(_ query: String) {

    }
    
    private func setupNavigation() {
        definesPresentationContext = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - Delegates

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - SearchController

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        if text.count > 3 && lastKeyWordTyped != text {
            fetchRequest(text)
            lastKeyWordTyped = text
        }
    }

}

extension SearchViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "")
        
        if text.count > 3 && lastKeyWordTyped != text {
            fetchRequest(text)
            lastKeyWordTyped = text
        }
        
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
