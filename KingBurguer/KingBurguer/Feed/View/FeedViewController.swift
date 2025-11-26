//
//  FeedViewController.swift
//  KingBurguer
//
//  Created by angelo on 21/10/25.
//

import UIKit

class FeedViewController: UIViewController {
    // Para que uma UITableView funcione é necessário
    
    // 1 - registrar uma classe que seja uma UITableViewCell ou filha dela
    // tableView.register(UITableViewCell.self,...
    
    // 2 - definir o dataSource / delegate (ViewController)
    // extension FeedViewController: UITableViewDataSource {...
    
    // 3 - nos metodos implementados 'func tableView' você deve definir:
    // --- o numero de linhas 'numberOfRowsInSection' que deve ser retornado
    // --- qual é a celula especifica daquela linha com 'cellForRowAt' aonde o 'indexPath' devolve a celula correta sendo renderizada
    // nesse caso voce ira visualizar apenas 14 linhas mas ao rolar as proximas serao geradas apartir de linhas que ja foram anteriormente criadas
    // por exemplo: a linha 0 sai da vizualizacao da tela na rolagem e a linha 15 surge, e assim por diante
    
    let sections = ["Top Burguers", "Vegan", "Meat", "Dessert"]
    
    // UITableView só funciona se houver uma UITableViewCell
    private let homeFeedTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        
        return tableView
    }()
    
    var viewModel: FeedViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        let headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 350))
        headerView.backgroundColor = .black
        homeFeedTable.tableHeaderView = headerView
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavBar()
        
        viewModel?.fetchFeed()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavBar(){
        navigationItem.title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var image = UIImage(named: "icon")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "power"), style: .done, target: self, action: #selector(testDidTap))
        ]
    }
    
    @objc func testDidTap(_ sender: UIBarButtonItem){
        print("Ok")
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // numero de linhas da sessao
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.bounds.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.text = sections[section].uppercased()
        
        view.addSubview(label)
        
        return view
    }
    
    // celulas das linhas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        //cell.textLabel?.text = "sessão: \(indexPath.section) - linha: \(indexPath.row)"
        return cell
    }
    
}

extension FeedViewController: FeedViewModelDelegate {
    func viewModelDidChanged(state: FeedState) {
        switch(state) {
        case .loading:
            print("OK!!!")
            break
        case .success:
            print("NOK!!!")
            break
        case .error(let errorMessage):
            print("ERROR!!! \(errorMessage)")
            break
        }
    }
}
