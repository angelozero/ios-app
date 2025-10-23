//
//  GridViewController.swift
//  KingBurguer
//
//  Created by angelo on 22/10/25.
//

import UIKit

class GridViewController: UIViewController {
    
    // A UICollectionView exige um layout para saber como dispor as células.
    // Usamos UICollectionViewFlowLayout para layouts de grade (grid) simples.
    private let collectionView: UICollectionView = {
        
        // 1. Cria o layout
        let layout = UICollectionViewFlowLayout()
        
        // A orientação de rolagem é vertical (padrão)
        layout.scrollDirection = .vertical
        
        // 2. Inicializa a Collection View com o layout
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // 3. Registra uma célula básica (UICollectionViewCell) para reutilização
        // Assim como na UITableView, é crucial registrar a célula.
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "grid-cell-id")
        cv.backgroundColor = .systemBackground
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        // 4. Define o dataSource e o delegate (para o layout e interações)
        // O Delegate é necessário para implementar os métodos de tamanho da célula.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Define que a Collection View ocupa todo o espaço da tela
        collectionView.frame = view.bounds
    }
}

// O DataSource é responsável por fornecer os dados e as células
extension GridViewController: UICollectionViewDataSource {
    
    // Define o número de itens (células) em uma seção
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Exemplo: 3 colunas * 10 linhas = 30 itens
        return 30
    }
    
    // Define qual célula deve ser exibida para um item específico
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "grid-cell-id", for: indexPath)
        
        cell.backgroundColor = .lightGray // Cor de fundo para fácil visualização
        cell.layer.cornerRadius = 8 // Adicionar um toque visual
        
        // Adicionando um UILabel para mostrar o número do item
        // É uma maneira simples de adicionar conteúdo a uma UICollectionViewCell básica
        let tagLabel = 99
        
        // 1. Verifica se o UILabel já existe para evitar recriação
        if let existingLabel = cell.contentView.viewWithTag(tagLabel) as? UILabel {
            existingLabel.text = "Item \(indexPath.item + 1)"
        } else {
            // 2. Se não existir, cria e adiciona
            let label = UILabel()
            label.tag = tagLabel
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 14)
            label.textColor = .darkText
            label.text = "Item \(indexPath.item + 1)"
            
            // Configura o layout do label para preencher a célula
            label.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor)
            ])
        }
        
        return cell
    }
}

// O Delegate Flow Layout é responsável por configurar o tamanho e o espaçamento dos itens
extension GridViewController: UICollectionViewDelegateFlowLayout {
    
    // Espaçamento que você deseja entre as células e as bordas
    private var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    // Espaço mínimo entre os itens na mesma linha (colunas)
    private var interItemSpacing: CGFloat {
        return 5
    }

    // Define o tamanho de cada item (célula)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns: CGFloat = 3
        
        // Largura total de espaçamento (2x bordas + (3-1)x espaços entre colunas)
        let totalSpacing = sectionInsets.left + sectionInsets.right +
                           ((numberOfColumns - 1) * interItemSpacing)
        
        // Calcula a largura que cada célula terá
        let width = (collectionView.bounds.width - totalSpacing) / numberOfColumns
        
        // Define a altura, por exemplo, um pouco maior que a largura
        let height = width * 1.2
        
        return CGSize(width: width, height: height)
    }

    // Define os insets (margens) da seção
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // Define o espaçamento mínimo entre as colunas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }

    // Define o espaçamento mínimo entre as linhas
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Espaçamento vertical entre as linhas
    }
}
