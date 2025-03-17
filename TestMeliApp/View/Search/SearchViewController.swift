import UIKit
import MBProgressHUD
import RxSwift
import RxCocoa
import CocoaLumberjack

private struct Cells {
    static let listTableViewCell = "ListTableViewCell"
}

class SearchViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    
    // MARK: - Properties
    private var hud: MBProgressHUD?
    private var lastKeyWordTyped: String = ""
    private var minCharacters: Int = 3
    private var searchTableDataSource: [SearchProduct]?
    
    var searchViewModel = SearchViewModel()
    
    fileprivate struct Segues {
        static let detailViewController = "detailSegue"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindView()
        bindTableView()
        setupNavigationBar()
    }
    
    private func bindView() {
        searchTextField.delegate = self
        searchTextField.placeholder = "Search..."
        searchTextField.borderStyle = .roundedRect
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        setupTableView()
    }
    
    private func fetchRequest(_ query: String) {
        showLoading()
        
        // MARK: SearchViewModel
        searchViewModel.getAutosuggest(query)
        
        searchViewModel.autosuggestResultBehavior
            .subscribe(
                onNext: { [weak self] (response) in
                    self?.hideLoading()
                    let stringResults = response.map { $0.name }
                    
                    if stringResults.count > 0 {
                        self?.showAutosuggestResults(for: stringResults)
                    }
                }, onError: { (error) in
                    self.showAlert(message: error.localizedDescription)
                }).disposed(by: disposeBag)
        
        searchViewModel.searchResultBehavior
            .subscribe(
                onNext: { [weak self] (response) in
                    self?.hideLoading()
                    self?.searchTableDataSource = response
                }, onError: { (error) in
                    self.showAlert(message: error.localizedDescription)
                }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        searchTableView.rx.setDelegate(self).disposed(by: disposeBag)
        searchTableView.register(UINib(nibName: Cells.listTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.listTableViewCell)
        searchTableView.keyboardDismissMode = .onDrag
        searchTableView.alwaysBounceVertical = false
    }
    
    private func bindTableView() {
        // MARK: TableView
        searchTableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let item = self.searchTableDataSource?[indexPath.row]
                self.performSegue(withIdentifier: Segues.detailViewController, sender: item)
            }).disposed(by: super.disposeBag)
        
        // MARK: ViewModel
        searchViewModel.searchResultBehavior
            .bind(to: searchTableView.rx.items(cellIdentifier: Cells.listTableViewCell, cellType: ListTableViewCell.self)) { row, item, cell in
            cell.setupValues(data: item)
            cell.accessoryType = .disclosureIndicator
        }.disposed(by: super.disposeBag)
    }
    
    private func setupNavigationBar() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showLoading() {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.label.text = Constants.Text.loading
    }
    
    func hideLoading() {
        hud?.hide(animated: true)
    }
    
    func showAutosuggestResults(for allItems: [String]) {
        let searchVC = AutosuggestTableViewController()
        searchVC.modalPresentationStyle = .overCurrentContext
        searchVC.view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        searchVC.delegate = self
        
        // Añade el controlador de resultados como hijo.
        addChild(searchVC)
        view.addSubview(searchVC.view)
        
        // Configuración de constraints.
        searchVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchVC.view.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 5),
            searchVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5) // Ocupa la mitad de la pantalla
        ])
        
        // Notifica al controlador hijo que ha sido añadido.
        searchVC.didMove(toParent: self)
        
        // Resultados basados en el texto del buscador.
        searchVC.items.accept(allItems)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            if let item = sender as? SearchProduct {
                detailVC.item = item
            }
        }
    }
}

// MARK: - Delegates

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if let product = self.searchTableDataSource?[indexPath.row] {
            let isFavourite = FavoritesHelper.shared.isSaved(product: product)
            let title = isFavourite ? "Remove favourite" : "Add favourite"
            
            let contextItem = UIContextualAction(style: .normal, title: title) { (contextualAction, view, boolValue) in
                self.searchTableView.reloadData()
                boolValue(true)
            }
            
            if isFavourite {
                contextItem.backgroundColor = .systemRed
            } else {
                do {
                    try FavoritesHelper.shared.save(product: product)
                    self.showAlert(message: Constants.Text.addfavorites)
                } catch {
                    
                }
                contextItem.backgroundColor = .systemYellow
            }
            
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            
            return swipeActions
        }
        
        return nil
    }
}

// MARK: - SearchController

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text.count > minCharacters && lastKeyWordTyped != text {
            fetchRequest(text)
            lastKeyWordTyped = text
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "")
        
        if text.count > minCharacters && lastKeyWordTyped != text {
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

extension SearchViewController: SearchTableViewControllerDelegate {
    func didSelectItem(_ item: String) {
        DDLogInfo("Item seleccionado: \(item)")
        self.searchTextField.text = item
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.searchViewModel.getSearchByWord(item)
        }
    }
}
