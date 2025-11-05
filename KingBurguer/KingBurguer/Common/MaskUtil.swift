//
//  MaskUtil.swift
//  KingBurguer
//
//  Created by angelo on 04/11/25.
//

import Foundation

class MaskUtil {
    
    private let mask: String
    var auxOldString: String = ""
    
    init(mask: String) {
        self.mask = mask
    }
    
    func process(value: String) -> String? {
        // 1. String com apenas dígitos (limpa de caracteres especiais da máscara)
        let str = replaceSpecialChars(value: value)
        
        // 2. Determinar se é deleção:
        // Deve haver uma propriedade 'auxOldString' que guarda a string limpa ANTERIOR.
        // É uma DELEÇÃO se a nova string limpa 'str' for menor que a anterior 'auxOldString'.
        let isDelete = str.count < auxOldString.count // Uso a contagem para ser mais claro
        
        // ATUALIZAÇÃO IMPORTANTE: Armazene o novo valor limpo para a próxima iteração
        auxOldString = str
        
        // 3. Verifica se a string limpa é maior que o permitido pela máscara
        let maxDigits = mask.filter { $0 == "#" }.count
        if str.count > maxDigits {
            // Retorna a string anterior para evitar adicionar o dígito extra
            // O valor retornado deve ser o resultado da aplicação da máscara na string limpa *anterior* (auxOldString)
            // Mas para simplificar, você pode retornar a 'value' com o último caractere removido.
            return String(value.dropLast())
        }
        
        // 4. Aplica a máscara na string limpa 'str'
        var result = ""
        var index = 0 // Índice para percorrer a string 'str'
        
        for char in mask {
            if char == "#" {
                // Tenta pegar o próximo dígito da string limpa 'str'
                let characterValue = str.charAtIndex(index: index)
                
                // Se não houver mais dígitos para preencher o '#' da máscara, para o loop
                guard let charValue = characterValue else { break }
                
                result.append(charValue)
                index += 1
                
            } else {
                // Caractere fixo da máscara ('.', '-')
                // Garante que o caractere fixo só é adicionado se houver pelo menos
                // um dígito logo em seguida (ou se já tivermos dígitos preenchidos)
                if index < str.count {
                    result.append(char)
                } else {
                    // Se não há mais dígitos, e é um caractere fixo, paramos.
                    // Exemplo: se digitou "123", e a máscara tem "###.###",
                    // ele preencheu 3 dígitos, achou o '.', mas não tem o 4º dígito.
                    // Ele para aqui, e o '.' não é adicionado.
                    break
                }
            }
        }
        
        return result
    }
    
    private func replaceSpecialChars(value: String) -> String {
        // 1. Define o conjunto de caracteres permitido: apenas dígitos (0-9).
        let allowedCharacters = CharacterSet.decimalDigits
        
        // 2. Filtra a string, mantendo apenas os caracteres que pertencem ao conjunto permitido.
        let filteredString = value.unicodeScalars.filter { allowedCharacters.contains($0) }
        
        // 3. Converte a coleção filtrada de volta para uma String.
        return String(filteredString)
    }
}
