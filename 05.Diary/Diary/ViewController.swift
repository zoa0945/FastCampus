//
//  ViewController.swift
//  Diary
//
//  Created by Mac on 2021/12/10.
//

/*
 UITabBarController
    - UITabBer는 앱에서 서로다른 하위작업, 뷰, 모드 사이에 선택을 할 수 있도록 tabBar에 하나 혹은 하나이상의 버튼을 보여줌
    - 다중 선택 인터페이스를 관리하는 컨테이너뷰컨트롤러로 선택에 따라 어떤 자식 뷰컨트롤러를 보여줄지 결정해줌

 UICollectionView
    - 데이터 항목에 정렬된 컬렉션을 관리하고 커스텀한 레이아웃을 사용해 표시하는 객체
    - ScrollView를 상속받고 다양한 레이아웃을 보여줄 때 사용
    - Cell: 컬렉션 뷰의 컨텐츠를 표시
    - Supplementary View: 섹션에 대한 정보를 표시
    - Decoration View: 컬렉션뷰에 대한 배경을 꾸밀때 사용
 
 NotificationCenter
    - 등록된 이벤트가 발새하면 해당 이벤트들에 대한 행동을 취함
    - 앱 내에서 아무데서나 메세지를 던지면 다른 아무데서나 메세지를 받을 수 있음
 */

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var diaryList: [Diary] = [] {
        didSet {
            self.saveDiary()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadDiary()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(editDiaryNotification(_:)),
                                               name: NSNotification.Name("editDiary"),
                                               object: nil
        )
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(starDiaryNotification(_:)),
                                               name: NSNotification.Name("starDiary"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deleteDiaryNotification(_:)),
                                               name: NSNotification.Name("deleteDiary"),
                                               object: nil)
    }
    
    @objc func deleteDiaryNotification(_ notification: Notification) {
        guard let uuidString = notification.object as? String else { return }
        guard let idx = self.diaryList.firstIndex(where: {
            $0.uuidString == uuidString
        }) else { return }
        self.diaryList.remove(at: idx)
        self.collectionView.deleteItems(at: [IndexPath(row: idx, section: 0)])
    }
    
    @objc func starDiaryNotification(_ notification: Notification) {
        guard let starDiary = notification.object as? [String: Any] else { return }
        guard let isStar = starDiary["isStar"] as? Bool else { return }
        guard let uuidString = starDiary["uuidString"] as? String else { return }
        guard let idx = self.diaryList.firstIndex(where: {
            $0.uuidString == uuidString
        }) else { return }
        self.diaryList[idx].isStar = isStar
    }
    
    @objc func editDiaryNotification(_ notification: Notification) {
        guard let diary = notification.object as? Diary else { return }
        guard let idx = self.diaryList.firstIndex(where: {
            $0.uuidString == diary.uuidString
        }) else { return }
        self.diaryList[idx] = diary
        self.diaryList = self.diaryList.sorted(by: {
            $0.date.compare($1.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
    
    private func saveDiary() {
        let data = self.diaryList.map{
            [
                "uuidString": $0.uuidString,
                "title": $0.title,
                "contents": $0.contents,
                "date": $0.date,
                "isStar": $0.isStar
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "diaryList")
    }
    
    private func loadDiary() {
        let userDefauls = UserDefaults.standard
        guard let data = userDefauls.object(forKey: "diaryList") as? [[String: Any]] else { return }
        self.diaryList = data.compactMap{
            guard let title = $0["title"] as? String else { return nil }
            guard let contents = $0["contents"] as? String else { return nil }
            guard let date = $0["date"] as? Date else { return nil }
            guard let isStar = $0["isStar"] as? Bool else { return nil }
            guard let uuidString = $0["uuidString"] as? String else { return nil }
            return Diary(uuidString: uuidString,
                         title: title,
                         contents: contents,
                         date: date,
                         isStar: isStar)
        }
        self.diaryList = self.diaryList.sorted(by: { d1, d2 in
            d1.date.compare(d2.date) == .orderedDescending
        })
    }

    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let writeDiaryViweController = segue.destination as? WriteDiaryViewController {
            writeDiaryViweController.delegate = self
        }
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

extension ViewController: WriteDiaryViewDelegate {
    func didSelectRegister(diary: Diary) {
        self.diaryList.append(diary)
        self.diaryList = self.diaryList.sorted(by: { d1, d2 in
            d1.date.compare(d2.date) == .orderedDescending
        })
        self.collectionView.reloadData()
    }
    
//    func didSelectStar(indexPath: IndexPath, isStar: Bool) {
//        self.diaryList[indexPath.row].isStar = isStar
//    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.diaryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DiaryCell", for: indexPath) as? DiaryCell else { return UICollectionViewCell() }
        
        let diary = self.diaryList[indexPath.row]
        cell.titleLabel.text = diary.title
        cell.dateLabel.text = self.dateToString(date: diary.date)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    // 셀의 사이즈를 설정, 표시할 셀의 사이즈를 CGSize로 정의 후 리턴
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DiaryDetailViewController") as? DiaryDetailViewController else { return }
        let diary = self.diaryList[indexPath.row]
        viewController.diary = diary
        viewController.indexPath = indexPath
//        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: DiaryDetailViewDelegate {
//    func didSelectDelete(indexPath: IndexPath) {
//        self.diaryList.remove(at: indexPath.row)
//        self.collectionView.deleteItems(at: [indexPath])
//    }
}
