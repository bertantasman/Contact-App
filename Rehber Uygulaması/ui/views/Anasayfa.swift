//
//  ViewController.swift
//  Rehber Uygulaması
//
//  Created by Bertan Taşman on 3.12.2024.
//

import UIKit

class Anasayfa: UIViewController {

    @IBOutlet weak var kisilerTableView: UITableView!
    var kisilerListesi = [Person]()
    private var emptyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self

        setupEmptyLabel()
        updateEmptyLabelVisibility()
    }

    private func setupEmptyLabel() {
        
        emptyLabel = UILabel()
        emptyLabel.text = "Kişi listeniz boş"
        emptyLabel.textColor = .gray
        emptyLabel.textAlignment = .center
        emptyLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(emptyLabel)

        
        NSLayoutConstraint.activate([
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func updateEmptyLabelVisibility() {
        
        emptyLabel.isHidden = !kisilerListesi.isEmpty
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? KisiKayit {
            if let selectedPerson = sender as? Person {
                destinationVC.editingPerson = selectedPerson
                destinationVC.completion = { updatedPerson in
                    if let index = self.kisilerListesi.firstIndex(where: { $0.name == updatedPerson.name && $0.surname == updatedPerson.surname }) {
                        self.kisilerListesi[index] = updatedPerson
                        self.kisilerTableView.reloadData()
                        self.updateEmptyLabelVisibility()
                    }
                }
            } else {
                destinationVC.editingPerson = nil
                destinationVC.completion = { newPerson in
                    self.kisilerListesi.append(newPerson)
                    self.kisilerTableView.reloadData()
                    self.updateEmptyLabelVisibility()
                }
            }
        }
    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toCreatePerson", sender: nil)
    }
}

extension Anasayfa: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateEmptyLabelVisibility()
        return kisilerListesi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListesi[indexPath.row]
        
        let hucre = tableView.dequeueReusableCell(withIdentifier: "kisilerHucre") as! KisilerHucre
        hucre.labelKisiAd.text = kisi.name
        hucre.labelKisiSoyad.text = kisi.surname
        hucre.labekKisiNumara.text = kisi.phone
        
        if kisi.gender == .male {
            hucre.imageGender.image = UIImage(named: "man") ?? UIImage(named: "defaultMale")
        } else if kisi.gender == .female {
            hucre.imageGender.image = UIImage(named: "woman") ?? UIImage(named: "defaultFemale")
        }

        return hucre
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = kisilerListesi[indexPath.row]
        performSegue(withIdentifier: "toEditPerson", sender: selectedPerson)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, bool in
            let selectedPerson = self.kisilerListesi[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(selectedPerson.name) silinecek. Emin misiniz?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.kisilerListesi.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.updateEmptyLabelVisibility()
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [silAction])
    }
}
