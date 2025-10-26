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
    
    // UITableView só funciona se houver uma UITableViewCell
    private let homeFeedTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        tableView.backgroundColor = .systemBackground
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        let headerView = HighlightView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 350))
        headerView.backgroundColor = .black
        homeFeedTable.tableHeaderView = headerView
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    // numero de linhas da sessao
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // celulas das linhas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        //cell.textLabel?.text = "sessão: \(indexPath.section) - linha: \(indexPath.row)"
        return cell
    }
    
}
