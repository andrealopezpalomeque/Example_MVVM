//
//  ViewModelList.swift
//  Example_MVVM
//
//  Created by Andrea Victoria López Palomeque on 09/10/2023.
//

import Foundation

class ViewModelList {
    
    //crear mecanismo para enlazar la VISTA con este MODELO DE LA VISTA
    //mediante closure se mantiene actualizada la vista
    var refreshData = {() -> () in } //devuelve lo que le estemos pasando
    
    
    //fuente de datos (array)
    var dataArray : [List] = []{
        didSet { //cuando se actualice el array, se actualiza la vista
            refreshData()
        }
    }
    
    // ❌ se deberia crear una capa de conexion, para instanciar desde aca
    
    //obtener datos de la API
    
    
     func retriveDataList()  {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            //parsear datos, convertirlos a un objeto
            do {
                let decoder = JSONDecoder()
                let list = try decoder.decode([List].self, from: data)
                self.dataArray = list
            } catch let error {
                print("Ha ocurrido un error: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
}
