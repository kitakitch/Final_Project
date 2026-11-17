import UIKit

class LibraryViewController: UIViewController {

    // MARK: - IBOutlets (เชื่อมต่อตามหน้าตา UI ของคุณ)
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var mediaCollectionView: UICollectionView!

    // MARK: - Data Models
    struct MediaItem {
        let title: String
        let creator: String
        let category: String
        let status: String
        let rating: String
        let posterName: String
        var isFavorite: Bool
    }

    let categories = ["ทั้งหมด (42)", "ซีรีส์ (6)", "อนิเมะ (8)", "หนังสือ (12)", "นิยาย (8)", "การ์ตูน (9)"]
    var selectedCategoryIndex = 0

    var allMediaItems: [MediaItem] = [
        MediaItem(title: "ปาฏิหาริย์ร้านชำของคุณนามิยะ", creator: "ฮิงาชิโนะ เคโงะ", category: "นิยาย", status: "อ่านจบแล้ว", rating: "5.0", posterName: "namiya_poster", isFavorite: true),
        MediaItem(title: "Spirited Away", creator: "Hayao Miyazaki", category: "อนิเมะ", status: "ดูจบแล้ว", rating: "4.8", posterName: "spirited_poster", isFavorite: false),
        MediaItem(title: "Atomic Habits", creator: "James Clear", category: "หนังสือ", status: "อ่านจบแล้ว", rating: "4.5", posterName: "atomic_poster", isFavorite: false),
        MediaItem(title: "Reply 1988", creator: "Shin Won-ho", category: "ซีรีส์", status: "ดูจบแล้ว", rating: "5.0", posterName: "reply1988_poster", isFavorite: false)
    ]
    
    var filteredMediaItems: [MediaItem] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredMediaItems = allMediaItems
        setupDelegates()
    }

    private func setupDelegates() {
        searchBar.delegate = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        mediaCollectionView.delegate = self
        mediaCollectionView.dataSource = self
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categories.count
        }
        return filteredMediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath)
            // ตั้งค่าป้ายหมวดหมู่
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCell", for: indexPath)
        // ตั้งค่าการ์ดสื่อ
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension LibraryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // ระบบกรองข้อมูลเมื่อพิมพ์ค้นหา
    }
}
