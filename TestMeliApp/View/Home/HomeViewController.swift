import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import MBProgressHUD

private struct Cells {
    static let recommendedTableViewCell = "RecommendedTableViewCell"
    static let productCollectionViewCell = "ProductCollectionViewCell"
}

class HomeViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var recommendedTableView: UITableView!
    @IBOutlet weak var searchButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    private var hud: MBProgressHUD?
    private var categoryOneCollectionDataSource: [SearchProduct]?
    private var categoryTwoTableDataSource: [SearchProduct]?
    
    var searchViewModel = SearchViewModel()
    var oauthViewModel = OAuthViewModel()
    var categoriesViewModel = CategoriesViewModel()
    
    let refreshControl = UIRefreshControl()
    
    var oauthTokenSubject = PublishSubject<OAuthToken>()
    var firstCategorySubject = PublishSubject<OAuthToken>()
    var secondCategorySubject = PublishSubject<OAuthToken>()
    var error = PublishSubject<String>()

    fileprivate struct Segues {
        static let detailViewController = "detailSegue"
        static let searchViewController = "searchSegueViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindView()
        setupCollectionView()
        setupTableView()
        setupNavigationBar()
        setupRefreshControl()
    }
    
    private func setupCollectionView() {
        productCollectionView
            .rx.setDelegate(self).disposed(by: super.disposeBag)
        productCollectionView.register(UINib(nibName: Cells.productCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: Cells.productCollectionViewCell)
    }
    
    private func setupTableView() {
        recommendedTableView
            .rx.setDelegate(self).disposed(by: super.disposeBag)
        recommendedTableView.register(UINib(nibName: Cells.recommendedTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.recommendedTableViewCell)
        
        recommendedTableView.keyboardDismissMode = .onDrag
        recommendedTableView.alwaysBounceVertical = false
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Cargando datos...")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        recommendedTableView.refreshControl = refreshControl
    }
    
    private func bindView() {
        showLoading()
        categoriesViewModel.getCategories()
        oauthViewModel.getUser()
        oauthViewModel.refreshToken()
        
        bindCollectionView()
        bindTableView()
    }
    
    private func bindCollectionView() {
        
        // MARK: CollectionView
        productCollectionView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let item =  self.categoryOneCollectionDataSource?[indexPath.row]
                self.performSegue(withIdentifier: Segues.detailViewController, sender: item)
            }).disposed(by: super.disposeBag)
        
        // MARK: ViewModel
        categoriesViewModel.firstCategoryBehavior
            .bind(to: productCollectionView.rx.items(cellIdentifier: Cells.productCollectionViewCell, cellType: ProductCollectionViewCell.self)) { row, item, cell in
                
                cell.setupView(image: item.thumbnail)
            }.disposed(by: super.disposeBag)
        
        oauthViewModel.oauthBehavior
            .subscribe(
                onNext: { [weak self] (response) in
                    self?.oauthTokenSubject.onNext(response)
                }, onError: { (error) in
                    self.error.onNext(error.localizedDescription)
                    self.showAlert(message: error.localizedDescription)
                }).disposed(by: disposeBag)
        
        categoriesViewModel.categoriesBehavior
            .subscribe(
                onNext: { [weak self] (response) in
                    if !response.isEmpty {
                        self?.categoriesViewModel.getFirstCategory()
                        self?.categoriesViewModel.getLastCategory()
                    }
                }, onError: { (error) in
                    self.error.onNext(error.localizedDescription)
                    self.showAlert(message: error.localizedDescription)
                }).disposed(by: disposeBag)
        
        categoriesViewModel.firstCategoryBehavior
            .subscribe(
                onNext: { [weak self] (response) in
                    self?.hideLoading()
                    self?.categoryOneCollectionDataSource = response
                }, onError: { (error) in
                    self.error.onNext(error.localizedDescription)
                    self.showAlert(message: error.localizedDescription)
                }).disposed(by: disposeBag)
        
        categoriesViewModel.lastCategoryBehavior
            .subscribe(
                onNext: { [weak self] (response) in
                    self?.hideLoading()
                    self?.categoryTwoTableDataSource = response
                }, onError: { (error) in
                    self.error.onNext(error.localizedDescription)
                    self.showAlert(message: error.localizedDescription)
                }).disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        
        // MARK: TableView
        recommendedTableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let item =  self.categoryTwoTableDataSource?[indexPath.row]
                self.performSegue(withIdentifier: Segues.detailViewController, sender: item)
            }).disposed(by: super.disposeBag)
        
        // MARK: ViewModel
        categoriesViewModel.lastCategoryBehavior.bind(to: recommendedTableView.rx.items(cellIdentifier: Cells.recommendedTableViewCell, cellType: RecommendedTableViewCell.self)) { row, item, cell in
            cell.setupValues(data: item)
            cell.accessoryType = .disclosureIndicator
        }.disposed(by: super.disposeBag)
    }
    
    func setupNavigationBar() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = Constants.Text.titleBar
    }
    
    func showLoading() {
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud?.label.text = Constants.Text.loading
    }

    func hideLoading() {
        hud?.hide(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            if let item = sender as? SearchProduct {
                detailVC.item = item
            }
        }
    }
    
    @IBAction func reloadDataAction(_ sender: Any) {
        searchViewModel.getSearchCollection("")
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton!) {
        self.performSegue(withIdentifier: Segues.searchViewController, sender: self)
    }

    @objc func refreshData() {
        bindView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    // MARK: - Swipe
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        if let _ = self.categoryTwoTableDataSource?[indexPath.row] {
            let isFavourite = false
            let title = isFavourite ? "Remove favourite" : "Add favourite"
            
            let contextItem = UIContextualAction(style: .normal, title: title) { (contextualAction, view, boolValue) in
                self.recommendedTableView.reloadData()
                boolValue(true)
            }
            
            if isFavourite {
                contextItem.backgroundColor = .systemRed
            } else {
                contextItem.backgroundColor = .systemYellow
            }
            
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            
            return swipeActions
        }
        
        return nil
    }
    
}

