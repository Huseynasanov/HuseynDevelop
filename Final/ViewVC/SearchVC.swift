//
//  ViewController.swift
//  Final
//
//  Created by Huseyn Hasanov on 28.03.22.
//

import UIKit
import SDWebImage
class SearchVC: UIViewController, UISearchBarDelegate{
    
    var vm = SearchVM()
    var newsdata : NewsData?
    var todaysnews : NewsData?

    @IBAction func LangugeBtns(_ sender: UIButton){
        LanguageView.isHidden = true
        LanguageChangeBtns.setTitle(sender.titleLabel?.text ?? "EN", for: .normal)
        UserDefaults.standard.set(sender.titleLabel?.text, forKey: "lang")
        let text = SearchField.text?.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? ""
        let lang = (sender.titleLabel?.text?.lowercased() ?? "en").addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? ""
        vm.getNews(text: text, lang: lang)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.vm.getTodayNews(lang: lang)
        })
    }
    @IBOutlet weak var LanguageView: UIView!{
        didSet{
            LanguageView.isHidden = true
            LanguageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var LanguageChangeBtns: UIButton!{
        didSet{
            LanguageChangeBtns.layer.cornerRadius = 15
            LanguageChangeBtns.setTitle((UserDefaults.standard.object(forKey: "lang") as? String) ?? "EN", for: .normal)
            LanguageChangeBtns.semanticContentAttribute = .forceRightToLeft
        }
    }
    @IBAction func LanguageBtnAction(_ sender: Any) {
        
        if  LanguageView.isHidden{
            LanguageView.isHidden = false

        }else{
            LanguageView.isHidden = true
        }
    }
 
    @IBOutlet weak var NewsTableView: UITableView!{
        didSet{
            NewsTableView.delegate = self
            NewsTableView.dataSource = self
        }
    }
    @IBOutlet weak var CurentDate: UILabel!
    @IBOutlet weak var SearchField: UISearchBar!{
            didSet{
                SearchField.delegate = self
            }
        }
    
    @IBOutlet weak var TodaysNewsCollectionView: UICollectionView!{
        didSet{
            TodaysNewsCollectionView.delegate = self
            TodaysNewsCollectionView.dataSource = self
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        let backButton = UIBarButtonItem()
        backButton.title = newsdata?.articles?[0].title
        backButton.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        CurentDate.text = DateFormatter.localizedString(from: Date(), dateStyle: .long, timeStyle: .none)
        NewsTableView.separatorColor = .clear
        NewsTableView.separatorStyle = .none
        vm.getTodayNews(lang: (UserDefaults.standard.object(forKey: "lang") as? String)?.lowercased() ?? "en")
        setBinding()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchField.endEditing(true)
        let text = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? ""
        vm.getNews(text: text, lang: (UserDefaults.standard.object(forKey: "lang") as? String)?.lowercased() ?? "en")
    }
}
extension SearchVC{
    func setBinding(){
        vm.successOnSearch = { data in
            self.newsdata = data
            DispatchQueue.main.async {
                print("data\(data)")
                self.NewsTableView.reloadData()
            }
            print(data)
        }
        vm.successOnToday = { dat in
            self.todaysnews = dat
            DispatchQueue.main.async {
                print("data\(dat)")
                self.TodaysNewsCollectionView.reloadData()
            }
            print(dat)
        }
    }
}
extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todaysnews?.articles?.count ?? 0
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! SearchCollectionViewCellVC
        cell.contentView.backgroundColor = .white
        cell.media.sd_setImage(with: (URL(string: (todaysnews?.articles?[indexPath.row].media) ?? "")), completed: nil)
        cell.title.text = todaysnews?.articles?[indexPath.row].title
        cell.topic.text = todaysnews?.articles?[indexPath.row].topic
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        vc.image = todaysnews?.articles?[indexPath.row].media
        vc.summary = todaysnews?.articles?[indexPath.row].summary
        vc.excrept =  todaysnews?.articles?[indexPath.row].excerpt
        vc.author = todaysnews?.articles?[indexPath.row].author
        vc.topic = todaysnews?.articles?[indexPath.row].topic
        vc.name = todaysnews?.articles?[indexPath.row].title
        vc.ID = todaysnews?.articles?[indexPath.row]._id
        vc.Publish_Date = todaysnews?.articles?[indexPath.row].published_date
        vc.link = todaysnews?.articles?[indexPath.row].link
        vc.twiterAuthor = todaysnews?.articles?[indexPath.row].twitter_account
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 180)
    }
}

extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsdata?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tablecell = tableView.dequeueReusableCell(withIdentifier: "image",for: indexPath) as! SearchTableViewCellVC
        tablecell.media.sd_setImage(with: (URL(string: (newsdata?.articles?[indexPath.row].media) ?? "")), completed: nil)
        tablecell.result.text = newsdata?.articles?[indexPath.row].title
        tablecell.topicLabelSearch.text = newsdata?.articles?[indexPath.row].topic
        let date = newsdata?.articles?[indexPath.row].published_date ?? ""
        tablecell.data.text = String(date.split(separator: " ")[0])
        tablecell.writer.text = newsdata?.articles?[indexPath.row].author
        tablecell.selectionStyle = .none
        return tablecell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "InfoVC") as! InfoVC
        vc.image = newsdata?.articles?[indexPath.row].media
        vc.summary = newsdata?.articles?[indexPath.row].summary
        vc.excrept =  newsdata?.articles?[indexPath.row].excerpt
        vc.author = newsdata?.articles?[indexPath.row].author
        vc.topic = newsdata?.articles?[indexPath.row].topic
        vc.name = newsdata?.articles?[indexPath.row].title
        vc.ID = newsdata?.articles?[indexPath.row]._id
        vc.Publish_Date = newsdata?.articles?[indexPath.row].published_date
        vc.link = newsdata?.articles?[indexPath.row].link
        vc.twiterAuthor = newsdata?.articles?[indexPath.row].twitter_account
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

