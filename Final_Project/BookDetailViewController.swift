//
//  BookDetailViewController.swift
//  Final_Project
//
//  Created by Koonladar yannakonchomchan on 17/11/2569 BE.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Model
    
    struct BookDetail {
        let coverImage: UIImage?
        let tags: [String]
        let title: String
        let subtitle: String
        let author: String
        let publisher: String
        let pageCount: Int
        let finishedDateText: String      // เช่น "จบเมื่อ 23 ม.ค. 2024 · ใช้เวลา 6 วัน"
        let rating: Double                // 0...5
        let review: String
        let shelfName: String
        let isFinished: Bool
    }
    
    // MARK: - Theme
    
    private enum Theme {
        static let background  = UIColor(red: 0.973, green: 0.957, blue: 0.933, alpha: 1)  // ครีม
        static let card        = UIColor.white
        static let primary     = UIColor(red: 0.247, green: 0.286, blue: 0.118, alpha: 1)  // เขียวมะกอกเข้ม
        static let primaryTint = UIColor(red: 0.914, green: 0.929, blue: 0.839, alpha: 1)  // เขียวอ่อน
        static let textMain    = UIColor(red: 0.12, green: 0.12, blue: 0.10, alpha: 1)
        static let textSub     = UIColor.darkGray
        static let danger      = UIColor(red: 0.80, green: 0.18, blue: 0.20, alpha: 1)
    }
    
    // MARK: - ViewController
    
    final class BookDetailViewController: UIViewController {
        
        // MARK: Outlets – Navigation
        @IBOutlet weak var bookmarkButton: UIBarButtonItem!
        @IBOutlet weak var moreButton: UIBarButtonItem!
        
        // MARK: Outlets – Scroll
        @IBOutlet weak var scrollView: UIScrollView!
        
        // MARK: Outlets – Cover
        @IBOutlet weak var coverImageView: UIImageView!
        @IBOutlet weak var finishedBadgeView: UIView!        // ป้าย "อ่านจบแล้ว"
        @IBOutlet weak var finishedBadgeLabel: UILabel!
        @IBOutlet weak var finishedBadgeIcon: UIImageView!
        
        // MARK: Outlets – Tags
        @IBOutlet weak var tagsStackView: UIStackView!
        @IBOutlet var tagLabels: [UILabel]!                   // 3 แท็ก (ใส่ใน container view ที่มีพื้นหลัง)
        @IBOutlet var tagContainerViews: [UIView]!
        
        // MARK: Outlets – Title area
        @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var subtitleLabel: UILabel!
        @IBOutlet weak var authorLabel: UILabel!              // "สิงาชิโนะเคโงะ · น้ำพุสำนักพิมพ์ · 512 หน้า"
        
        // MARK: Outlets – Finished date pill
        @IBOutlet weak var dateContainerView: UIView!
        @IBOutlet weak var dateIconImageView: UIImageView!
        @IBOutlet weak var dateLabel: UILabel!
        
        // MARK: Outlets – Rating card
        @IBOutlet weak var ratingCardView: UIView!
        @IBOutlet weak var ratingValueLabel: UILabel!         // "5.0"
        @IBOutlet weak var ratingMaxLabel: UILabel!           // "/ 5.0"
        @IBOutlet weak var ratingCaptionLabel: UILabel!       // "ตะแนนความประทับใจโดยรวม"
        @IBOutlet weak var starsContainerView: UIView!        // พื้นหลังเขียวอ่อนมน
        @IBOutlet weak var starsStackView: UIStackView!       // ใส่ UIImageView 5 ดวง
        @IBOutlet var starImageViews: [UIImageView]!
        
        // MARK: Outlets – Review card
        @IBOutlet weak var reviewCardView: UIView!
        @IBOutlet weak var reviewTitleIcon: UIImageView!
        @IBOutlet weak var reviewTitleLabel: UILabel!         // "บันทึกความรู้สึก & รีวิว"
        @IBOutlet weak var editIconButton: UIButton!          // ปุ่มดินสอกลมๆ
        @IBOutlet weak var reviewBodyLabel: UILabel!
        
        // MARK: Outlets – Actions
        @IBOutlet weak var editNoteButton: UIButton!          // "แก้ไขบันทึกเล่มนี้"
        @IBOutlet weak var shelfCardView: UIView!
        @IBOutlet weak var shelfIconImageView: UIImageView!
        @IBOutlet weak var shelfLabel: UILabel!
        @IBOutlet weak var deleteButton: UIButton!            // "ลบรายการนี้"
        
        // MARK: Data
        var book: BookDetail?
        
        //        // MARK: Lifecycle
        //        override func viewDidLoad() {
        //            super.viewDidLoad()
        //            setupAppearance()
        //            if let book { configure(with: book) } else { configure(with: Self.sample) }
        //        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // ทำให้ container ที่เป็นแคปซูลมนเต็มทรง
            [finishedBadgeView, dateContainerView, starsContainerView].forEach {
                $0?.layer.cornerRadius = ($0?.bounds.height ?? 0) / 2
            }
            tagContainerViews?.forEach { $0.layer.cornerRadius = $0.bounds.height / 2 }
            editIconButton.layer.cornerRadius = editIconButton.bounds.height / 2
        }
        
        // MARK: - Appearance
        private func setupAppearance() {
            view.backgroundColor = Theme.background
            scrollView.backgroundColor = Theme.background
            scrollView.showsVerticalScrollIndicator = false
            
            // Navigation
            title = "หน้ารายละเอียดเรื่อง"
            navigationController?.navigationBar.tintColor = Theme.textMain
            bookmarkButton.image = UIImage(systemName: "bookmark")
            moreButton.image = UIImage(systemName: "ellipsis")
            
            // Cover
            coverImageView.contentMode = .scaleAspectFill
            coverImageView.clipsToBounds = true
            coverImageView.layer.cornerRadius = 16
            coverImageView.layer.shadowColor = UIColor.black.cgColor
            
            // Badge "อ่านจบแล้ว"
            finishedBadgeView.backgroundColor = Theme.primaryTint
            finishedBadgeIcon.image = UIImage(systemName: "checkmark.circle.fill")
            finishedBadgeIcon.tintColor = Theme.primary
            finishedBadgeLabel.font = .systemFont(ofSize: 12, weight: .semibold)
            finishedBadgeLabel.textColor = Theme.primary
            finishedBadgeLabel.text = "อ่านจบแล้ว"
            
            // Tags
            tagContainerViews.forEach {
                $0.backgroundColor = Theme.primaryTint
                $0.layer.borderWidth = 0.5
                $0.layer.borderColor = Theme.primary.withAlphaComponent(0.25).cgColor
            }
            tagLabels.forEach {
                $0.font = .systemFont(ofSize: 11, weight: .medium)
                $0.textColor = Theme.primary
                $0.textAlignment = .center
            }
            
            // Title
            titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
            titleLabel.textColor = Theme.textMain
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            
            subtitleLabel.font = .systemFont(ofSize: 13)
            subtitleLabel.textColor = Theme.textSub
            subtitleLabel.numberOfLines = 0
            subtitleLabel.textAlignment = .center
            
            authorLabel.font = .systemFont(ofSize: 12)
            authorLabel.textColor = Theme.textSub
            authorLabel.textAlignment = .center
            
            // Date pill
            dateContainerView.backgroundColor = Theme.primaryTint.withAlphaComponent(0.6)
            dateIconImageView.image = UIImage(systemName: "calendar")
            dateIconImageView.tintColor = Theme.primary
            dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
            dateLabel.textColor = Theme.primary
            
            // Cards
            [ratingCardView, reviewCardView, shelfCardView].forEach { card in
                card?.backgroundColor = Theme.card
                card?.layer.cornerRadius = 16
                card?.layer.shadowColor = UIColor.black.cgColor
                card?.layer.shadowOpacity = 0.05
                card?.layer.shadowRadius = 6
                card?.layer.shadowOffset = CGSize(width: 0, height: 2)
            }
            
            // Rating
            ratingValueLabel.font = .systemFont(ofSize: 28, weight: .bold)
            ratingValueLabel.textColor = Theme.primary
            ratingMaxLabel.font = .systemFont(ofSize: 14)
            ratingMaxLabel.textColor = Theme.textSub
            ratingCaptionLabel.font = .systemFont(ofSize: 11)
            ratingCaptionLabel.textColor = Theme.textSub
            ratingCaptionLabel.text = "ระดับความประทับใจโดยรวม"
            starsContainerView.backgroundColor = Theme.primaryTint
            starsStackView.spacing = 4
            starsStackView.distribution = .fillEqually
            
            // Review
            reviewTitleIcon.image = UIImage(systemName: "pencil.and.scribble")
            reviewTitleIcon.tintColor = Theme.primary
            reviewTitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
            reviewTitleLabel.textColor = Theme.textMain
            reviewTitleLabel.text = "บันทึกความรู้สึก & รีวิว"
            reviewBodyLabel.font = .systemFont(ofSize: 14, weight: .medium)
            reviewBodyLabel.textColor = Theme.textMain
            reviewBodyLabel.numberOfLines = 0
            
            editIconButton.backgroundColor = Theme.primaryTint
            editIconButton.setImage(UIImage(systemName: "pencil"), for: .normal)
            editIconButton.tintColor = Theme.primary
            editIconButton.setTitle(nil, for: .normal)
            
            // Edit button (filled)
            var filled = UIButton.Configuration.filled()
            filled.baseBackgroundColor = Theme.primary
            filled.baseForegroundColor = .white
            filled.cornerStyle = .capsule
            filled.image = UIImage(systemName: "square.and.pencil")
            filled.imagePadding = 8
            filled.title = "แก้ไขบันทึกเล่มนี้"
            filled.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
            editNoteButton.configuration = filled
            
            // Shelf
            shelfIconImageView.image = UIImage(systemName: "heart.fill")
            shelfIconImageView.tintColor = Theme.textMain
            shelfLabel.font = .systemFont(ofSize: 12)
            shelfLabel.textColor = Theme.textMain
            
            // Delete
            var plain = UIButton.Configuration.plain()
            plain.baseForegroundColor = Theme.danger
            plain.image = UIImage(systemName: "trash")
            plain.imagePadding = 6
            plain.title = "ลบรายการนี้"
            deleteButton.configuration = plain
        }
        
        // MARK: - Configure
        func configure(with book: BookDetail) {
            coverImageView.image = book.coverImage
            finishedBadgeView.isHidden = !book.isFinished
            
            for (index, label) in tagLabels.enumerated() {
                let hasTag = index < book.tags.count
                label.text = hasTag ? book.tags[index] : nil
                tagContainerViews[index].isHidden = !hasTag
            }
            
            titleLabel.text = book.title
            subtitleLabel.text = book.subtitle
            authorLabel.attributedText = makeAuthorText(book)
            dateLabel.text = book.finishedDateText
            
            ratingValueLabel.text = String(format: "%.1f", book.rating)
            ratingMaxLabel.text = "/ 5.0"
            updateStars(rating: book.rating)
            
            reviewBodyLabel.text = book.review
            shelfLabel.text = "บันทึกอยู่ใน \"\(book.shelfName)\""
        }
        
        private func makeAuthorText(_ book: BookDetail) -> NSAttributedString {
            let result = NSMutableAttributedString(
                string: book.author,
                attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold),
                             .foregroundColor: Theme.textMain])
            result.append(NSAttributedString(
                string: "  •  \(book.publisher)  •  \(book.pageCount) หน้า",
                attributes: [.font: UIFont.systemFont(ofSize: 12),
                             .foregroundColor: Theme.textSub]))
            return result
        }
        
        private func updateStars(rating: Double) {
            for (index, star) in starImageViews.enumerated() {
                let value = Double(index) + 1
                let name: String
                if rating >= value { name = "star.fill" }
                else if rating >= value - 0.5 { name = "star.leadinghalf.filled" }
                else { name = "star" }
                star.image = UIImage(systemName: name)
                star.tintColor = Theme.primary
                star.contentMode = .scaleAspectFit
            }
        }
        
        // MARK: - Actions
        @IBAction func backTapped(_ sender: Any) {
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func bookmarkTapped(_ sender: UIBarButtonItem) {
            let isFilled = sender.image == UIImage(systemName: "bookmark.fill")
            sender.image = UIImage(systemName: isFilled ? "bookmark" : "bookmark.fill")
        }
        
        @IBAction func moreTapped(_ sender: UIBarButtonItem) {
            // TODO: แสดงเมนูเพิ่มเติม
        }
        
        @IBAction func editIconTapped(_ sender: UIButton) {
            openEditor()
        }
        
        @IBAction func editNoteTapped(_ sender: UIButton) {
            openEditor()
        }
        
        @IBAction func deleteTapped(_ sender: UIButton) {
            let alert = UIAlertController(title: "ลบรายการนี้?",
                                          message: "ข้อมูลและรีวิวของหนังสือเล่มนี้จะถูกลบถาวร",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ยกเลิก", style: .cancel))
            alert.addAction(UIAlertAction(title: "ลบ", style: .destructive) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            present(alert, animated: true)
        }
        
        private func openEditor() {
            // TODO: push หน้าแก้ไขบันทึก
        }
    }

    // MARK: - Sample Data
//    extension BookDetailViewController {
//        static let sample = BookDetail(
//            coverImage: UIImage(named: "namiya_cover"),
//            tags: ["นิยายแปลญี่ปุ่น", "แฟนตาซีอบอุ่น", "ซาบซึ้งหัวใจ"],
//            title: "ปาฏิหาริย์ร้านชำของคุณนามิยะ",
//            subtitle: "The Miracles of the Namiya General Store (ナミヤ雑貨店の奇蹟)",
//            author: "ฮิงาชิโนะ เคโงะ",
//            publisher: "น้ำพุสำนักพิมพ์",
//            pageCount: 512,
//            finishedDateText: "จบเมื่อ 23 ม.ค. 2024  •  ใช้เวลา 6 วัน",
//            rating: 5.0,
//            review: """
//            นี่ไม่ใช่แค่นิยายสืบสวนตามสไตล์ทั่วไปของ อ.เคโงะ แต่มันคืออรรถกรรมที่เยียวยาจิตวิญญาณได้อย่างดงามที่สุด โครงเรื่องแบ่งเรื่องเป็นจดหมายปรึกษาปัญหาชีวิตหลายๆ ฉบับที่ส่งข้ามมิติเวลาผ่านกล่องรับจดหมายของร้านชำนามิยะในค่ำคืนหนึ่ง
//
//            สิ่งที่ประทับใจคือ ทุกความผูกพันถูกถักทอเข้าหากันอย่างแยบยล ทุกคำตอบไม่ได้ให้ทางลัดที่สมบูรณ์แบบ แต่กลับกระตุ้นให้เจ้าของจดหมายเผชิญหน้ากับความลังเลของตัวเอง
//            """,
//            shelfName: "ชั้นหนังสือเล่มโปรดตลอดกาล",
//            isFinished: true
//        )
//    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    ;func
    
    // MARK: - Sample Data
    //    extension BookDetailViewController {
    //        static let sample = BookDetail(
    //            coverImage: UIImage(named: "namiya_cover"),
    //            tags: ["นิยายแปลญี่ปุ่น", "แฟนตาซีอบอุ่น", "ซาบซึ้งหัวใจ"],
    //            title: "ปาฏิหาริย์ร้านชำของคุณนามิยะ",
    //            subtitle: "The Miracles of the Namiya General Store (ナミヤ雑貨店の奇蹟)",
    //            author: "ฮิงาชิโนะ เคโงะ",
    //            publisher: "น้ำพุสำนักพิมพ์",
    //            pageCount: 512,
    //            finishedDateText: "จบเมื่อ 23 ม.ค. 2024  •  ใช้เวลา 6 วัน",
    //            rating: 5.0,
    //            review: """
    //            นี่ไม่ใช่แค่นิยายสืบสวนตามสไตล์ทั่วไปของ อ.เคโงะ แต่มันคืออรรถกรรมที่เยียวยาจิตวิญญาณได้อย่างดงามที่สุด โครงเรื่องแบ่งเรื่องเป็นจดหมายปรึกษาปัญหาชีวิตหลายๆ ฉบับที่ส่งข้ามมิติเวลาผ่านกล่องรับจดหมายของร้านชำนามิยะในค่ำคืนหนึ่ง
    //
    //            สิ่งที่ประทับใจคือ ทุกความผูกพันถูกถักทอเข้าหากันอย่างแยบยล ทุกคำตอบไม่ได้ให้ทางลัดที่สมบูรณ์แบบ แต่กลับกระตุ้นให้เจ้าของจดหมายเผชิญหน้ากับความลังเลของตัวเอง
    //            """,
    //            shelfName: "ชั้นหนังสือเล่มโปรดตลอดกาล",
    //            isFinished: true
    //        )
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
    //}
}
