
import UIKit

class GenreTableViewCell : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.layer.cornerRadius = 10
        customView.clipsToBounds = true
    }
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var genreLbl: UILabel!
}

class GenreVC: UIViewController {
    var genres : Genres?
    var filterGenres : Genres? = []
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var genreTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Genres"
        self.genreTV.showsVerticalScrollIndicator = false
        self.genres = getGenres()
        filterGenres = genres
       
        let placeholderText = "Search"
        let placeholderColor = UIColor.red.withAlphaComponent(CGFloat(10))

        
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])

        
        searchTF.attributedPlaceholder = attributedPlaceholder
        searchTF.placeholder = placeholderText
        searchTF.borderStyle = .none
        searchTF.layer.cornerRadius = 8
        searchTF.layer.borderWidth = 1
        searchTF.layer.borderColor = UIColor.red.cgColor
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let imageView = UIImageView(image: UIImage(named: "search"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 5, y: 5, width: 25, height: 25)
        leftView.addSubview(imageView)
        
        searchTF.leftView = leftView
        searchTF.leftViewMode = .always
        
    }

}

extension GenreVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterGenres?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : GenreTableViewCell = tableView.dequeueReusableCell(ofType: GenreTableViewCell.self, for: indexPath)
        cell.genreLbl.text = filterGenres?[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = getMoviesGenres(forGenre: filterGenres![indexPath.row])
        let nextVC = AllMovieVC.instantiateViewController() as? AllMovieVC
        nextVC?.movies = data
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    
}

extension GenreVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        print("Search text: \(searchText)")
        
        
        if searchText.isEmpty {
            self.filterGenres = genres
        }
        else {
            self.filterGenres = genres?.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        
        DispatchQueue.main.async {
            self.genreTV.reloadData()
        }
        return true
    }
}
