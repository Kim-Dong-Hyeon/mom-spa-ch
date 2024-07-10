//
//  Controller.swift
//  MomSpaCh
//
//  Created by 김동현 on 7/2/24.
//

import UIKit

import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                      CustomTableViewCellDelegate, UICollectionViewDelegate,
                      MenuCollectionViewCellDelegate, UICollectionViewDataSource,
                      UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

  var checkDuplication: Bool = false
  var menuData = MenuData()
  var filteredMenuData: [MenuItem] = []
  static let identifier = "mainViewController"
  private let countLabel = UILabel()
  private let nameLabel = UILabel()

  let cellCount = 4
  var currentIndex = 0

// MARK: - UIViewController, UIButton, UILabel, UIImageView (Developer: 조수환)

  var mainView: MainView!
  override func loadView() {
    super.loadView()
    mainView = MainView(frame: self.view.frame)
    self.view = mainView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchTextField()
    setupTableView()
    setupCollectionView()
    setupActions()
    filteredMenuData = menuData.menuArray
    setupGestureRecognizers()
    setupDismissKeyboardGesture()
  }

  private func setupActions() {
    mainView.clearButton.addTarget(
      self,
      action: #selector(clearSearchText),
      for: .touchUpInside
    )
    mainView.searchButton.addTarget(
      self,
      action: #selector(searchButtonTapped),
      for: .touchUpInside
    )
    mainView.segmentedControl.addTarget(
      self,
      action: #selector(categoryChanged(_:)),
      for: .valueChanged
    )
    mainView.showNextMenu.addTarget(
      self,
      action: #selector(nextButtonTapped),
      for: .touchUpInside
    )
    mainView.showPreviousMenu.addTarget(
      self,
      action: #selector(previousButtonTapped),
      for: .touchUpInside
    )
    mainView.cancelButton.addTarget(
      self,
      action: #selector(cancelButtonTapped),
      for: .touchUpInside
    )
    mainView.orderButton.addTarget(
      self,
      action: #selector(orderButtonTapped),
      for: .touchUpInside
    )
    mainView.dutchPlus.addTarget(
      self,
      action: #selector(dutchPlusTapped),
      for: .touchUpInside
    )
    mainView.dutchMinus.addTarget(
      self,
      action: #selector(dutchMinusTapped),
      for: .touchUpInside
    )
  }

// MARK: - UITextField, UIButton, UISegmentedControl (Developer: 김동현)

  private func setupSearchTextField() {
    mainView.searchTextField.delegate = self
    mainView.searchTextField.rightView = mainView.clearButton
    mainView.searchTextField.rightViewMode = .whileEditing
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchButtonTapped()
    textField.resignFirstResponder()
    return true
  }

  @objc private func clearSearchText() {
    mainView.searchTextField.text = ""
    filteredMenuData = menuData.menuArray

    // 선택된 카테고리에 따라 다시 필터링
    if mainView.selectedCategory != "all" {
      filteredMenuData = filteredMenuData.filter { $0.category == mainView.selectedCategory }
    }
    mainView.menuCollectionView.reloadData()
    clearPagingControl()
    currentIndex = 0
  }
  
  private func setupDismissKeyboardGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }

  @objc private func searchButtonTapped() {
    menuDataFilter()
    clearPagingControl()
    currentIndex = 0
    // 검색 결과가 없을 때 처리 추가
    if filteredMenuData.isEmpty {
      mainView.pageControl.numberOfPages = 0
      mainView.pageControl.currentPage = 0
    }
  }

  /// categoryChanged: UISegmentedControl의 값이 변경되었을 때 호출되는 메서드
  /// - Parameter sender: UISegmentedControl
  @objc private func categoryChanged(_ sender: UISegmentedControl) {
//    currentIndex = 0
    switch sender.selectedSegmentIndex {
    case 0:
      mainView.selectedCategory = "all"
    case 1:
      mainView.selectedCategory = "burger"
    case 2:
      mainView.selectedCategory = "chicken"
    case 3:
      mainView.selectedCategory = "sideMenu"
    case 4:
      mainView.selectedCategory = "drink"
    default:
      mainView.selectedCategory = "all"
    }
    
    menuDataFilter()
    currentIndex = 0
  }

// MARK: - UICollectionView, UIButton, UIPageControl (Developer: 김윤홍)

  /// 컬렉션뷰 만들기
  func setupCollectionView() {
    mainView.menuCollectionView.dataSource = self
    mainView.menuCollectionView.delegate = self
    mainView.menuCollectionView.register(
      MenuCollectionViewCell.self,
      forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
  }

  /// 컬렉션뷰 셀을 컬렉션 뷰 안에 넣기
  /// - Parameters:
  ///   - collectionView: 넣어야할 컬렉션뷰
  ///   - indexPath: cell indexPath
  /// - Returns: 다운캐스팅 실패시 기본셀 리턴
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MenuCollectionViewCell.identifier,
      for: indexPath
    ) as? MenuCollectionViewCell else {
      return UICollectionViewCell()
    }
    let startIndex = currentIndex * cellCount
    let item = filteredMenuData[startIndex + indexPath.item]
    cell.configure(withImageName: item.imageName, price: item.menuPrice, name: item.menuName)
    cell.delegate = self
    return cell
  }

  /// 컬렉션 뷰 내부 셀구성 개수 설정
  /// - Returns: 개수
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    let filteredMenu = filteredMenuData.filter {
      mainView.selectedCategory == "all" || $0.category == mainView.selectedCategory
    }
    let firstCell = currentIndex * cellCount
    let lastCell = min(firstCell + cellCount, filteredMenu.count)
    return lastCell - firstCell
  }

  /// collectionView 제약 조건
  /// - Returns: 사이즈
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: 130, height: 150)
  }

  @objc func nextButtonTapped() {
    let totalPages = (filteredMenuData.count + cellCount - 1) / cellCount
    if currentIndex < totalPages - 1 {
      currentIndex += 1
      mainView.menuCollectionView.reloadData()
      mainView.pageControl.currentPage = currentIndex
      buttonUpdate()
    }
  }

  @objc func previousButtonTapped() {
    if currentIndex > 0 {
      currentIndex -= 1
      mainView.menuCollectionView.reloadData()
      mainView.pageControl.currentPage = currentIndex
      buttonUpdate()
    }
  }

  func buttonUpdate() {
    let totalPages = (filteredMenuData.count + cellCount - 1) / cellCount
    if currentIndex < totalPages - 1 {
      mainView.showNextMenu.isEnabled = true
    } else if (currentIndex > 0) {
      mainView.showPreviousMenu.isEnabled = true
    } else {
      mainView.showNextMenu.isEnabled = false
      mainView.showPreviousMenu.isEnabled = false
    }
  }

  func clearPagingControl() {
    mainView.pageControl.numberOfPages = (filteredMenuData.count + cellCount - 1) / cellCount
    mainView.pageControl.currentPage = 0
//    currentIndex =
  }

// MARK: - UITableView, UIButton, UILabel, UIStackView (Developer: 백시훈)

  /// addOrderList
  /// - Parameters: 메뉴에서 버튼을 눌러 주문리스트에 추가하는 함수
  ///   - pay: 금액
  ///   - name: 상품
  func addOrderList(_ pay: String, _ name: String) { //
    if menuData.nameData.contains(name) {
      checkDuplication = true
      for i in 0..<menuData.nameData.count {
        if menuData.nameData[i] == name{
          menuData.countData[i] += 1
          menuData.priceData[i] += Int(pay)!
        }
      }
      mainView.allCount.text = String(menuData.countData.reduce(0, +))
    } else {
      checkDuplication = false
      menuData.nameData.append(name)
      menuData.priceData.append(Int(pay)!)
      menuData.countData.append(1)
    }
    mainView.allCount.text = String(menuData.countData.reduce(0, +))
    mainView.payLabel.text = String(menuData.priceData.reduce(0, +))
    mainView.tableView.reloadData()
    scrollToBottom(animated: true)
  }

  func scrollToBottom(animated: Bool) {
    let numberOfSections = mainView.tableView.numberOfSections
    let numberOfRows = mainView.tableView.numberOfRows(inSection: numberOfSections-1)
    if numberOfRows > 0 {
      let indexPath = IndexPath(row: numberOfRows-1, section: numberOfSections-1)
      mainView.tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
  }

  /// setupTableView: 테이블 뷰 생성
  func setupTableView() {
    mainView.tableView.dataSource = self
    mainView.tableView.delegate = self
    mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    mainView.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
  }

  /// tableView: 테이블 뷰의 cell을 갯수를 리턴하는 메서드
  /// - Parameters:
  ///   - tableView: 테이블 뷰
  ///   - section: 갯수
  /// - Returns: 테이블 cell 갯수
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return menuData.nameData.count
  }

  /// tableView: 테이블 뷰 구성요소 데이터 넣는 메서드
  /// - Parameters:
  ///   - tableView: 테이블 뷰
  ///   - indexPath: 선택된 cell
  /// - Returns: cell
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "CustomCell",
      for: indexPath
    ) as? CustomTableViewCell else {
      return UITableViewCell()
    }
    cell.itemNameLabel.text = menuData.nameData[indexPath.row]
    cell.countLabel.text = String(menuData.countData[indexPath.row])
    cell.plusButton.tag = indexPath.row
    cell.minusButton.tag = indexPath.row
    cell.payLabel.text = String(menuData.priceData[indexPath.row])
    cell.delegate = self
    return cell
  }

  /// deleteButton: cell에서 삭제된 데이터 처리
  /// - Parameter cell: 삭제 cell
  func deleteButton(in cell: CustomTableViewCell) {
    if let indexPath = mainView.tableView.indexPath(for: cell) {
      menuData.nameData.remove(at: indexPath.row)
      menuData.priceData.remove(at: indexPath.row)
      menuData.countData.remove(at: indexPath.row)
      mainView.tableView.deleteRows(at: [indexPath], with: .automatic)
      mainView.allCount.text = String(menuData.countData.reduce(0, +))
      mainView.payLabel.text = String(menuData.priceData.reduce(0, +))
    }
  }

  /// plusButtonTap: 플러스 버튼시 이벤트
  /// - Parameter cell: 플러스 버튼 누른 cell
  func plusButtonTap(in cell: CustomTableViewCell) {
    guard let indexPath = mainView.tableView.indexPath(for: cell) else {
      return
    }
    if let cell = mainView.tableView.cellForRow(
      at: indexPath
    ) as? CustomTableViewCell, let countText = cell.itemNameLabel.text {
      for i in 0..<menuData.nameData.count {
        if menuData.nameData[i] == countText {
          let count = Int(menuData.countData[i])
          menuData.countData[i] += 1
          menuData.countSum = menuData.countData.reduce(0, +)
          menuData.priceData[i] = (menuData.priceData[i] / count) * (count + 1)
          menuData.paySum = menuData.priceData.reduce(0, +)
        }
      }
    }
    mainView.allCount.text = String(menuData.countSum)
    mainView.payLabel.text = String(menuData.paySum)
  }

  /// minusButtonTap : 마이너스 버튼 클릭 이벤트 메서드
  /// - Parameter cell: 마이너스 버튼 누른 cell
  func minusButtonTap(in cell: CustomTableViewCell) {
    guard let indexPath = mainView.tableView.indexPath(for: cell) else {
      return
    }
    if let cell = mainView.tableView.cellForRow(at: indexPath) as? CustomTableViewCell,
       let countText = cell.itemNameLabel.text {
      for i in 0..<menuData.nameData.count {
        if menuData.nameData[i] == countText {
          let count = Int(menuData.countData[i])
          menuData.countData[i] -= 1
          menuData.countSum = menuData.countData.reduce(0, +)
          menuData.priceData[i] = (menuData.priceData[i] / count) * (count - 1)
          menuData.paySum = menuData.priceData.reduce(0, +)
        }
      }
      mainView.allCount.text = String(menuData.countSum)
      mainView.payLabel.text = String(menuData.paySum)
    }
  }

// MARK: - UIStackView, UIButton, UIAlertController, UISwipeGestureRecognizer (Developer: 최건)

  @objc func cancelButtonTapped() {
    orderListClear()
  }

  @objc func orderButtonTapped() {
    clickedOrderButton()
  }
  
  /// 주문 내역을 처음 상태로 초기화
  func orderListClear() {
    menuData.nameData = []
    menuData.priceData = []
    menuData.countData = []
    mainView.allCount.text = "0"
    mainView.payLabel.text = "0"
    updateDutchPay()
    mainView.dutchCount.text = "1"
    mainView.tableView.reloadData()
  }

  func clickedOrderButton() {
    if menuData.nameData.isEmpty {
      let emptyAlert = UIAlertController(
        title: "주문내역을 확인해 주십시오",
        message: "",
        preferredStyle: .alert
      )
      let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
      emptyAlert.addAction(okAction)
      present(emptyAlert, animated: true, completion: nil)
    } else {
      if Int(mainView.dutchCount.text!)! > 1 {
        let alert = UIAlertController(
          title: "최종 결제 금액 \(mainView.payLabel.text!)원입니다.\n  주문하시겠습니까?",
          message: "1인당 결제 금액은 \(mainView.dutchPay.text!)원 입니다.",
          preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
          self.orderCompletedAlert()
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
      } else {
        let alert = UIAlertController(
          title: "최종 결제 금액 \(mainView.payLabel.text!)원입니다.\n  주문하시겠습니까?",
          message: "",
          preferredStyle: .alert
        )
        let yesAction = UIAlertAction(title: "네", style: .default) { _ in
          self.orderCompletedAlert()
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
      }
    }
  }

  /// 최종 주문 완료 메세지
  private func orderCompletedAlert() {
    let completedAlert = UIAlertController(
      title: "주문 완료되었습니다.",
      message: "",
      preferredStyle: .alert
    )
    let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
    completedAlert.addAction(okAction)
    orderListClear()
    present(completedAlert, animated: true, completion: nil)
  }

  private func setupGestureRecognizers() {
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    swipeLeft.direction = .left
    mainView.menuCollectionView.addGestureRecognizer(swipeLeft)
    
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
    swipeRight.direction = .right
    mainView.menuCollectionView.addGestureRecognizer(swipeRight)
  }

  @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
    switch gesture.direction {
    case .left:
      if let nextCategoryIndex = getNextCategory(after: mainView.selectedCategory) {
        updateCategory(to: nextCategoryIndex)
      }
    case .right:
      if let previousCategoryIndex = getPreviousCategory(before: mainView.selectedCategory) {
        updateCategory(to: previousCategoryIndex)
      }
    default:
      break
    }
  }

// MARK: - 추가 함수 부분

  private func updateCategory(to newIndex: Int) {
    let categories = ["all", "burger", "chicken", "sideMenu", "drink"]
    mainView.segmentedControl.selectedSegmentIndex = newIndex
    mainView.selectedCategory = categories[newIndex]
    
    menuDataFilter()
    if !filteredMenuData.isEmpty {
      mainView.menuCollectionView.scrollToItem(
        at: IndexPath(item: 0, section: 0),
        at: .left, animated: true
      )
    }
    clearPagingControl()
    currentIndex = 0
  }
  
  private func menuDataFilter() {
    let searchText = mainView.searchTextField.text ?? ""

    if searchText.isEmpty {
      filteredMenuData = menuData.menuArray
    } else {
      filteredMenuData = menuData.menuArray.filter { menuItem in
        if searchText.range(of: "\\p{Hangul}", options: .regularExpression) != nil {
          // 검색어에 한글이 포함된 경우 menuName과 비교
          let containsMenuName = menuItem.menuName.contains(searchText)
          return containsMenuName
        } else {
          // 검색어에 한글이 포함되지 않은 경우 imageName과 비교
          let containsImageName = menuItem.imageName.lowercased().contains(searchText.lowercased())
          return containsImageName
        }
      }
    }
    // 선택된 카테고리에 따라 다시 필터링
    if mainView.selectedCategory != "all" {
      filteredMenuData = filteredMenuData.filter { $0.category == mainView.selectedCategory }
    }
    currentIndex = 0
    mainView.menuCollectionView.reloadData()
  }

  private func getNextCategory(after currentCategory: String) -> Int? {
    let categories = ["all", "burger", "chicken", "sideMenu", "drink"]
    if let currentIndex = categories.firstIndex(of: currentCategory) {
      let nextIndex = (currentIndex + 1) % categories.count
      return nextIndex
    }
    return nil
  }

  private func getPreviousCategory(before currentCategory: String) -> Int? {
    let categories = ["all", "burger", "chicken", "sideMenu", "drink"]
    if let currentIndex = categories.firstIndex(of: currentCategory) {
      let previousIndex = (currentIndex - 1 + categories.count) % categories.count
      return previousIndex
    }
    return nil
  }

  private func filterMenuData() {
    filteredMenuData = menuData.menuArray
    if mainView.selectedCategory != "all" {
      filteredMenuData = filteredMenuData.filter { $0.category == mainView.selectedCategory }
    }
  }

  @objc func dutchPlusTapped() {
    if let countText = mainView.dutchCount.text, let count = Int(countText) {
      mainView.dutchCount.text = String(count + 1)
      updateDutchPay()
    }
  }

  @objc func dutchMinusTapped() {
    if let countText = mainView.dutchCount.text, let count = Int(countText), count > 1 {
      mainView.dutchCount.text = String(count - 1)
      updateDutchPay()
    }
  }

  func updateDutchPay() {
    if let countText = mainView.dutchCount.text,
       let count = Int(countText),
       let totalAmountText = mainView.payLabel.text,
       let total = Int(totalAmountText) {
      let dutchAmount = total / count
      mainView.dutchPay.text = "\(dutchAmount)"
    }
  }
}
