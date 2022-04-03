//
//  SaveVC.swift
//  Final
//
//  Created by Huseyn Hasanov on 29.03.22.
//

import UIKit
import SDWebImage

class SaveVC: UIViewController {
    var savedID: [String] = UserDefaults.standard.object(forKey: "SaveID") as? [String] ?? []
    var savedName: [String] = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
    var savedPicture: [String] = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
    var savedPublishedDate: [String] = UserDefaults.standard.object(forKey: "SavedDate") as? [String] ?? []
    var savedAuthor: [String] = UserDefaults.standard.object(forKey: "SavedAuthor") as? [String] ?? []
    var savedTopic: [String] = UserDefaults.standard.object(forKey: "SavedTopic") as? [String] ?? []
    var savedExcrept: [String] = UserDefaults.standard.object(forKey: "SavedExcrept") as? [String] ?? []
    var savedSummary: [String] = UserDefaults.standard.object(forKey: "SavedSummary") as? [String] ?? []
    var savedLInk: [String] = UserDefaults.standard.object(forKey: "SavedLink") as? [String] ?? []
    var savedAuthorTwiter: [String] =  UserDefaults.standard.object(forKey: "SavedTwiter") as? [String] ?? []

    override func viewDidAppear(_ animated: Bool){
        print("save")
        savedAuthorTwiter =  UserDefaults.standard.object(forKey: "SavedTwiter") as? [String] ?? []
        savedPicture =  UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
        savedName =    UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
        savedAuthor = UserDefaults.standard.object(forKey: "SavedAuthor") as? [String] ?? []
        savedPublishedDate = UserDefaults.standard.object(forKey: "SavedDate") as? [String] ?? []
        savedID = UserDefaults.standard.object(forKey: "SaveID") as? [String] ?? []
        savedTopic = UserDefaults.standard.object(forKey: "SavedTopic") as? [String] ?? []
        savedExcrept =  UserDefaults.standard.object(forKey: "SavedExcrept") as? [String] ?? []
        savedSummary = UserDefaults.standard.object(forKey: "SavedSummary") as? [String] ?? []
        savedLInk =  UserDefaults.standard.object(forKey: "SavedLink") as? [String] ?? []
        SaveTableView.reloadData()
    }
    @IBOutlet weak var CurentDate: UILabel!
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        SaveTableView.separatorColor = .clear
        SaveTableView.separatorStyle = .none

        CurentDate.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)

    }
    @IBOutlet weak var SaveTableView: UITableView!{
        didSet{
            SaveTableView.delegate = self
            SaveTableView.dataSource = self
        }
    }
}
extension SaveVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tablcell = tableView.dequeueReusableCell(withIdentifier: "SaveTableViewCellVC",for: indexPath) as! SaveTableViewCellVC
        tablcell.titleLabel.text = savedName[indexPath.row]
        tablcell.authorLabel.text = savedAuthor[indexPath.row]
        tablcell.selectionStyle = .none
        print("News name\(savedName[indexPath.row])")//!
        tablcell.dateLabel.text = String(savedPublishedDate[indexPath.row].split(separator: " ")[0])
        tablcell.poster.sd_setImage(with: URL(string: savedPicture[indexPath.row]), completed: nil)
        tablcell.topicLabel.text = savedTopic[indexPath.row]
        return tablcell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        vc.image = savedPicture[indexPath.row]
        vc.summary = savedSummary[indexPath.row]
        vc.excrept =  savedExcrept[indexPath.row]
        vc.author = savedAuthor[indexPath.row]
        vc.topic = savedTopic[indexPath.row]
        vc.name = savedName[indexPath.row]
        vc.ID = savedID[indexPath.row]
        vc.Publish_Date = savedPublishedDate[indexPath.row]
        vc.link = savedLInk[indexPath.row]
        vc.twiterAuthor = savedAuthorTwiter[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

