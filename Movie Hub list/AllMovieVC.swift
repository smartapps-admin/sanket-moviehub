
import UIKit

class AllMovieTVC : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var castLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
}

class AllMovieVC: UIViewController {
    var movies : [MovieElement]?
    var filterMovies : [MovieElement]? = []
    @IBOutlet weak var allMoviewTableView: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        filterMovies = movies
       
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
extension AllMovieVC  : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
       return UIScreen.main.bounds.height / 4
       
   }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterMovies?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AllMovieTVC  = tableView.dequeueReusableCell(ofType: AllMovieTVC.self, for: indexPath)
        let movie = filterMovies![indexPath.row]
        cell.movieImg.kf.setImage(with: URL(string: movie.thumbnail ?? "") , placeholder: UIImage(named: "M"))
        cell.titleLbl.text = movie.title
        cell.castLbl.text = movie.cast?.isEmpty ?? false ? "No Cast Deatils" : movie.cast?[0]
        cell.yearLbl.text = "\(movie.year!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVc = DetailVC.instantiateViewController() as DetailVC
        let movie = filterMovies![indexPath.row]
        nextVc.movie = movie
        navigationController?.pushViewController(nextVc, animated: true)
    }
    
    
    
}

extension AllMovieVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let searchText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        print("Search text: \(searchText)")
        
        if searchText.isEmpty {
            self.filterMovies = movies
        }
        else {
            self.filterMovies = movies?.filter { $0.title!.lowercased().contains(searchText.lowercased()) }
        }
        
        DispatchQueue.main.async {
            self.allMoviewTableView.reloadData()
        }
        return true
    }
}
