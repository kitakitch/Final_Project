////
////  LibraryViewController.swift
////  Final_Project
////
////  Created by Koonladar yannakonchomchan on 17/11/2569 BE.
////
//
//import UIKit
//
//class LibraryViewController: UIViewController {
//
//        // MARK: - IBOutlets (เชื่อมต่อจาก Storyboard)
//        @IBOutlet weak var totalBadgeLabel: UILabel!              // ป้าย "● 42 รายการ"
//        @IBOutlet weak var searchBar: UISearchBar!                // ช่องค้นหา
//        @IBOutlet weak var categoryCollectionView: UICollectionView! // แถบหมวดหมู่แนวนอน
//        @IBOutlet weak var sortButton: UIButton!                  // ปุ่ม "เรียงตาม: บันทึกล่าสุด"
//        @IBOutlet weak var gridToggleButton: UIButton!            // ปุ่มสลับมุมมอง Grid / List
//        @IBOutlet weak var mediaCollectionView: UICollectionView! // ตารางการ์ดสื่อ 2 คอลัมน์
//
//        // MARK: - Data Models (โครงสร้างข้อมูลจำลอง)
//        struct MediaItem {
//            let title: String
//            let creator: String
//            let category: String
//            let status: String
//            let rating: String
//            let dateOrProgress: String
//            let posterName: String
//            var isFavorite: Bool
//        }
//
//        // หมวดหมู่ทั้งหมด
//        let categories = ["ทั้งหมด 42", "หนังสือ 12", "นิยาย 8", "การ์ตูน 9", "หนัง 7", "ซีรีส์ 6"]
//        var selectedCategoryIndex = 0
//
//        // ข้อมูลรายการสื่อทั้งหมด (ตามดีไซน์)
//        var allMediaItems: [MediaItem] = [
//            MediaItem(title: "ปาฏิหาริย์ร้านชำของคุ...", creator: "ฮิงาชิโนะ เคโงะ", category: "นิยาย", status: "อ่านจบแล้ว", rating: "5.0", dateOrProgress: "23 มี.ค. 2024", posterName: "namiya_poster", isFavorite: true),
//            MediaItem(title: "Spirited Away", creator: "Hayao Miyazaki", category: "อนิเมะ", status: "ดูจบแล้ว", rating: "4.8", dateOrProgress: "18 ก.พ. 2024", posterName: "spirited_poster", isFavorite: false),
//            MediaItem(title: "Atomic Habits", creator: "James Clear", category: "หนังสือ", status: "อ่านจบแล้ว", rating: "4.5", dateOrProgress: "10 มี.ค. 2024", posterName: "atomic_poster", isFavorite: false),
//            MediaItem(title: "Reply 1988", creator: "Shin Won-ho", category: "ซีรีส์", status: "ดูจบแล้ว", rating: "5.0", dateOrProgress: "2 เม.ย. 2024", posterName: "reply1988_poster", isFavorite: false),
//            MediaItem(title: "Frieren", creator: "Kanehito Yamada", category: "การ์ตูน", status: "กำลังอ่าน (เล่ม 8)", rating: "4.9", dateOrProgress: "72% • 2 ชม. ที่แล้ว", posterName: "frieren_poster", isFavorite: false),
//            MediaItem(title: "Past Lives", creator: "Celine Song", category: "หนัง", status: "ดูจบแล้ว", rating: "4.7", dateOrProgress: "28 เม.ย. 2024", posterName: "pastlives_poster", isFavorite: false)
//        ]
//        
//        var filteredMediaItems: [MediaItem] = []
//
//        // MARK: - Lifecycle
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            filteredMediaItems = allMediaItems
//            setupUI()
//            setupDelegates()
//        }
//
//        private func setupUI() {
//            totalBadgeLabel.layer.cornerRadius = 12
//            totalBadgeLabel.clipsToBounds = true
//            
//            // ลบเส้นขอบพื้นหลังของ SearchBar ให้กลมกลืนกับดีไซน์
//            searchBar.backgroundImage = UIImage()
//        }
//
//        private func setupDelegates() {
//            searchBar.delegate = self
//            
//            categoryCollectionView.delegate = self
//            categoryCollectionView.dataSource = self
//            
//            mediaCollectionView.delegate = self
//            mediaCollectionView.dataSource = self
//        }
//
//        // MARK: - Filter Logic (ระบบกรองข้อมูล)
//        private func filterContent() {
//            let searchText = searchBar.text?.lowercased() ?? ""
//            let selectedCategoryRaw = categories[selectedCategoryIndex].components(separatedBy: " ").first ?? "ทั้งหมด"
//
//            filteredMediaItems = allMediaItems.filter { item in
//                let matchesCategory = (selectedCategoryRaw == "ทั้งหมด") || (item.category == selectedCategoryRaw)
//                let matchesSearch = searchText.isEmpty ||
//                                    item.title.lowercased().contains(searchText) ||
//                                    item.creator.lowercased().contains(searchText)
//                return matchesCategory && matchesSearch
//            }
//            
//            mediaCollectionView.reloadData()
//        }
//
//        // MARK: - IBActions
//        @IBAction func didTapSortButton(_ sender: UIButton) {
//            let alert = UIAlertController(title: "เรียงลำดับตาม", message: nil, preferredStyle: .actionSheet)
//            alert.addAction(UIAlertAction(title: "บันทึกล่าสุด", style: .default, handler: { _ in
//                self.sortButton.setTitle("เรียงตาม: บันทึกล่าสุด ⌄", for: .normal)
//            }))
//            alert.addAction(UIAlertAction(title: "คะแนนสูงสุด", style: .default, handler: { _ in
//                self.sortButton.setTitle("เรียงตาม: คะแนนสูงสุด ⌄", for: .normal)
//                self.filteredMediaItems.sort { (Double($0.rating) ?? 0) > (Double($1.rating) ?? 0) }
//                self.mediaCollectionView.reloadData()
//            }))
//            alert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel))
//            present(alert, animated: true)
//        }
//    }
//
//    // MARK: - UISearchBarDelegate
//    extension LibraryViewController: UISearchBarDelegate {
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            filterContent()
//        }
//        
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            searchBar.resignFirstResponder()
//        }
//    }
//
//    // MARK: - UICollectionView DataSource & DelegateFlowLayout
//    extension LibraryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//        
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            if collectionView == categoryCollectionView {
//                return categories.count
//            }
//            return filteredMediaItems.count
//        }
//        
////        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////            // 1. กรณีเป็นแถบเลือกหมวดหมู่ด้านบน
////            if collectionView == categoryCollectionView {
////                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryPillCell", for: indexPath) as? CategoryPillCollectionViewCell else {
////                    return UICollectionViewCell()
////                }
////                let isSelected = (indexPath.item == selectedCategoryIndex)
////                cell.configure(title: categories[indexPath.item], isSelected: isSelected)
////                return cell
////            }
////            
////            // 2. กรณีเป็น Grid การ์ดสื่อ
////            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaGridCell", for: indexPath) as? MediaGridCollectionViewCell else {
////                return UICollectionViewCell()
////            }
//            
//            let item = filteredMediaItems[indexPath.item]
//            cell.configure(with: item)
//            
//            // จัดการเมื่อกดปุ่มหัวใจในการ์ด
//            cell.onFavoriteTapped = { [weak self] in
//                self?.filteredMediaItems[indexPath.item].isFavorite.toggle()
//                collectionView.reloadItems(at: [indexPath])
//            }
//            
//            return cell
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            if collectionView == categoryCollectionView {
//                selectedCategoryIndex = indexPath.item
//                categoryCollectionView.reloadData()
//                filterContent()
//            } else {
//                let selectedMedia = filteredMediaItems[indexPath.item]
//                print("กดเลือกเรื่อง: \(selectedMedia.title) -> เตรียมเปิดหน้ารายละเอียด")
//                // performSegue(withIdentifier: "ShowMediaDetail", sender: selectedMedia)
//            }
//        }
//        
//        // กำหนดขนาดของ Cell (2 คอลัมน์อัตโนมัติตามความกว้างหน้าจอ)
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            if collectionView == categoryCollectionView {
//                let text = categories[indexPath.item]
//                let width = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)]).width + 28
//                return CGSize(width: width, height: 34)
//            }
//            
//            let padding: CGFloat = 12 // ระยะห่างระหว่างการ์ด
//            let totalSpacing = padding * 3 // ซ้าย + กลาง + ขวา
//            let cardWidth = (collectionView.frame.width - totalSpacing) / 2
//            return CGSize(width: cardWidth, height: cardWidth * 1.85) // อัตราส่วนความสูงของการ์ด
//        }
//    }
////    override func viewDidLoad() {
////        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
