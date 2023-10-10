//
//  ViewController.swift
//  Example_MVVM
//
//  Created by Andrea Victoria López Palomeque on 09/10/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    var viewModel = ViewModelList()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView() 
        bindViewModel()
    }

    private func configureView(){
        activity.isHidden = false
        viewModel.retriveDataList()
        activity.startAnimating()
    }

    //configurar la conexion de la vista con el modelo de la vista
    private func bindViewModel(){
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData() //actualizar la vista
                self?.activity.stopAnimating() //detener animacion
                self?.activity.isHidden = true //ocultar animacion
            }
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!

        let object = viewModel.dataArray[indexPath.row]

        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.body
        
        return cell
    }
}

