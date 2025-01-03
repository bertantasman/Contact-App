//
//  KisiKayit.swift
//  Rehber Uygulaması
//
//  Created by Bertan Taşman on 4.12.2024.
//

import UIKit

class KisiKayit: UIViewController {

    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var tfKisiAd: UITextField!
    @IBOutlet weak var tfKisiSoyad: UITextField!
    @IBOutlet weak var tfKisiNumara: UITextField!

    var editingPerson: Person?
    var completion: ((Person) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let person = editingPerson {
            tfKisiAd.text = person.name
            tfKisiSoyad.text = person.surname
            tfKisiNumara.text = person.phone

            
            if person.gender == .male {
                genderPicker.selectedSegmentIndex = 0
            } else {
                genderPicker.selectedSegmentIndex = 1
            }

            
            tfKisiAd.isUserInteractionEnabled = false
            tfKisiSoyad.isUserInteractionEnabled = false
            genderPicker.isEnabled = false
        }
    }

    @IBAction func genderAction(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        let selectedGender = selectedIndex == 0 ? "Erkek" : "Kadın"
        print("Seçilen cinsiyet: \(selectedGender)")
    }

    @IBAction func buttonKaydet(_ sender: Any) {
        
        let kisiAd = tfKisiAd.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let kisiSoyad = tfKisiSoyad.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let kisiNumara = tfKisiNumara.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        
        if kisiAd.isEmpty || kisiSoyad.isEmpty || kisiNumara.isEmpty {
            let alert = UIAlertController(title: "Eksik Bilgi", message: "Lütfen tüm alanları doldurunuz.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        
        let gender = genderPicker.selectedSegmentIndex == 0 ? Gender.male : Gender.female

        
        if let person = editingPerson {
            
            let updatedPerson = Person(name: person.name, surname: person.surname, phone: kisiNumara, gender: gender)
            completion?(updatedPerson)
        } else {
            
            let newPerson = Person(name: kisiAd, surname: kisiSoyad, phone: kisiNumara, gender: gender)
            completion?(newPerson)
        }

        
        navigationController?.popViewController(animated: true)
    }
}
