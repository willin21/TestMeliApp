import UIKit
import RxSwift
import RxCocoa

private struct Cells {
    static let textTableViewCell = "CustomCell"
}

class AutosuggestTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    let items = BehaviorRelay<[String]>(value: []) // Lista de resultados.
    
    weak var delegate: SearchTableViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Cells.textTableViewCell)
        
        // Vincula los resultados al TableView.
        items
            .bind(to: tableView.rx.items(cellIdentifier: Cells.textTableViewCell, cellType: CustomTableViewCell.self)) { row, item, cell in
                cell.customLabel.text = item
                cell.accessoryType = .disclosureIndicator
            }.disposed(by: disposeBag)
        
        // Detecta cuando se selecciona un elemento.
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                let selectedItem = self.items.value[indexPath.row]
                
                self.delegate?.didSelectItem(selectedItem)
                
                self.dismiss(animated: false) {
                    self.willMove(toParent: nil)  // Notificar que será removido
                    self.view.removeFromSuperview()  // Quitar la vista de la jerarquía
                    self.removeFromParent()  // Remover del ciclo de vida
                }
            })
            .disposed(by: disposeBag)
    }
}
