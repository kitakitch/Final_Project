////
////  ProfileViewController.swift
////  Final_Project
////
////  Created by Koonladar yannakonchomchan on 17/11/2569 BE.
////
//
//import UIKit
//
//class ProfileViewController: UIViewController {
//
//        // MARK: - IBOutlets (เชื่อมต่อจาก Storyboard)
//        // 1. ส่วนหัวโปรไฟล์
//        @IBOutlet weak var profileImageView: UIImageView!
//        @IBOutlet weak var nameLabel: UILabel!
//        @IBOutlet weak var handleLabel: UILabel!
//        @IBOutlet weak var bioLabel: UILabel!
//        @IBOutlet weak var editProfileButton: UIButton!
//        
//        // 2. การ์ดเป้าหมายปี 2025 & สถิติ
//        @IBOutlet weak var goalCardView: UIView!
//        @IBOutlet weak var goalCountLabel: UILabel!      // เช่น "42 / 50 เรื่อง (84%)"
//        @IBOutlet weak var goalProgressView: UIProgressView!
//        @IBOutlet weak var bookCountLabel: UILabel!      // เช่น "18"
//        @IBOutlet weak var movieCountLabel: UILabel!     // เช่น "16"
//        @IBOutlet weak var animeCountLabel: UILabel!     // เช่น "8"
//        @IBOutlet weak var totalCountLabel: UILabel!     // เช่น "เสพครบแล้วทั้งหมด 42 เรื่อง"
//        @IBOutlet weak var avgRatingLabel: UILabel!      // เช่น "เฉลี่ย 4.8"
//        
//        // 3. เรื่องโปรดตลอดกาล (Horizontal Collection View)
//        @IBOutlet weak var favoritesCollectionView: UICollectionView!
//        
//        // 4. การตั้งค่า (สวิตช์แจ้งเตือน)
//        @IBOutlet weak var reminderSwitch: UISwitch!
//
//        // MARK: - Mock Data (ข้อมูลจำลองสำหรับทดสอบแสดงผล)
//        struct FavoriteItem {
//            let title: String
//            let category: String
//            let rating: String
//            let posterImageName: String
//        }
//        
//        var favoriteItems: [FavoriteItem] = [
//            FavoriteItem(title: "Frieren: Beyond Jour...", category: "อนิเมะ", rating: "5.0 • Masterpiece", posterImageName: "frieren_poster"),
//            FavoriteItem(title: "Reply 1988 (วันวาน 19...", category: "ซีรีส์", rating: "5.0 • อบอุ่นหัวใจ", posterImageName: "reply1988_poster"),
//            FavoriteItem(title: "ปาฏิหาริย์ร้านชำของ...", category: "นิยาย", rating: "4.9 • ซาบซึ้ง", posterImageName: "namiya_poster")
//        ]
//
//        // MARK: - Lifecycle
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            setupUI()
//            setupCollectionView()
//            loadProfileData()
//        }
//        
//        // MARK: - UI Setup (ตกแต่งความโค้งมนและเงาให้เหมือนดีไซน์)
//        private func setupUI() {
//            // ทำรูปโปรไฟล์เป็นวงกลม
//            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
//            profileImageView.clipsToBounds = true
//            
//            // ตกแต่งปุ่มแก้ไขโปรไฟล์
//            editProfileButton.layer.cornerRadius = 12
//            
//            // ตกแต่งการ์ดเป้าหมาย
//            goalCardView.layer.cornerRadius = 16
//            goalCardView.layer.borderWidth = 1
//            goalCardView.layer.borderColor = UIColor.systemGray5.cgColor
//            
//            // ปรับความสูง Progress Bar
//            goalProgressView.layer.cornerRadius = 4
//            goalProgressView.clipsToBounds = true
//        }
//        
//        private func setupCollectionView() {
//            favoritesCollectionView.delegate = self
//            favoritesCollectionView.dataSource = self
//        }
//        
//        // MARK: - Data Binding (นำข้อมูลมาใส่ UI)
//        private func loadProfileData() {
//            nameLabel.text = "Pimchanok W. (พิมพ์ชนก)"
//            handleLabel.text = "@pim.reads"
//            bioLabel.text = "บันทึกเรื่องราวผ่านตัวอักษรและแผ่นฟิล์ม ☕📖🎞️"
//            
//            // ตั้งค่าเป้าหมาย
//            let current = 42
//            let target = 50
//            let percentage = Float(current) / Float(target)
//            
//            goalCountLabel.text = "\(current) / \(target) เรื่อง (\(Int(percentage * 100))%)"
//            goalProgressView.setProgress(percentage, animated: true)
//            
//            bookCountLabel.text = "18"
//            movieCountLabel.text = "16"
//            animeCountLabel.text = "8"
//            totalCountLabel.text = "เสพครบแล้วทั้งหมด \(current) เรื่อง"
//            avgRatingLabel.text = "★ เฉลี่ย 4.8"
//        }
//
//        // MARK: - IBActions (ฟังก์ชันเมื่อผู้ใช้กดปุ่ม)
//        @IBAction func didTapEditProfile(_ sender: UIButton) {
//            print("เปิดหน้าต่างแก้ไขโปรไฟล์")
//            // เขียนโค้ดเปิดหน้า Modal แก้ไขชื่อ/รูปภาพตรงนี้
//        }
//        
//        @IBAction func didTapShareProfile(_ sender: UIButton) {
//            let shareText = "มาดูคลังหนังสือและซีรีส์ของ \(nameLabel.text ?? "") บน Archive & Shelf สิ!"
//            let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
//            present(activityVC, animated: true)
//        }
//        
//        @IBAction func didToggleReminder(_ sender: UISwitch) {
//            if sender.isOn {
//                print("เปิดการแจ้งเตือนอ่านหนังสือ 21:30 น.")
//            } else {
//                print("ปิดการแจ้งเตือน")
//            }
//        }
//        
//        @IBAction func didTapLogout(_ sender: UIButton) {
//            let alert = UIAlertController(title: "ออกจากระบบ", message: "คุณต้องการออกจากระบบใช่หรือไม่?", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel))
//            alert.addAction(UIAlertAction(title: "ออกจากระบบ", style: .destructive, handler: { _ in
//                print("ดำเนินการออกจากระบบ...")
//            }))
//            present(alert, animated: true)
//        }
//    }
//
//    // MARK: - UICollectionView DataSource & Delegate (สำหรับเรื่องโปรดตลอดกาล)
//    extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//        
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return favoriteItems.count
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            
//            let item = favoriteItems[indexPath.item]
//            cell.configure(with: item)
//            return cell
//        }
//        
//        // กำหนดขนาดของการ์ดแต่ละใบในแนวนอน
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//            return CGSize(width: 130, height: 210)
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
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
//
////}
