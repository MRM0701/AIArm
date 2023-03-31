//
//  AddPersonViewController.swift
//  AIArm
//
//  Created by zoneyet on 2023/3/30.
//

//import UIKit
//import SnapKit
//
//class AddPersonViewController: BaseViewController {
//
//    // MARK: - Properties
//
//    var selectedImage: UIImage?
//
//    // MARK: - UI Elements
//
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = true
//        return scrollView
//    }()
//
//    private let contentView: UIView = {
//        let view = UIView()
//        return view
//    }()
//
//    private let avatarImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 50
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .gray
//        return imageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "就诊人姓名"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "请输入就诊人姓名"
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let idNumberLabel: UILabel = {
//        let label = UILabel()
//        label.text = "身份证号"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let idNumberTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "请输入身份证号"
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let relationLabel: UILabel = {
//        let label = UILabel()
//        label.text = "与就诊人关系"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let relationPickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        return pickerView
//    }()
//
//    private let medicalHistoryLabel: UILabel = {
//        let label = UILabel()
//        label.text = "病史描述"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let medicalHistoryTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.layer.borderWidth = 1
//        textView.layer.borderColor = UIColor.lightGray.cgColor
//        return textView
//    }()
//
//    private let hospitalLabel: UILabel = {
//        let label = UILabel()
//        label.text = "默认医院"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let hospitalTextField: UITextField = {
//        let textField = UITextField()
//        textField.text = "昆儿医院"
//        textField.isEnabled = false
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    // MARK: - Lifecycle Methods
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//        setupConstraints()
//    }
//
//    // MARK: - UI Setup Methods
//
//    private func setupUI() {
//        title = "添加就诊人"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonPressed))
//
//        scrollView.addSubview(contentView)
//        view.addSubview(scrollView)
//
//        contentView.addSubviews(avatarImageView,
//                                nameLabel,
//                                nameTextField,
//                                idNumberLabel,
//                                idNumberTextField,
//                                relationLabel,
//                                relationPickerView,
//                                medicalHistoryLabel,
//                                medicalHistoryTextView,
//                                hospitalLabel,
//                                hospitalTextField)
//
//        nameTextField.addRequiredMark()
//        idNumberTextField.addRequiredMark()
//        relationLabel.addRequiredMark()
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
//        avatarImageView.isUserInteractionEnabled = true
//        avatarImageView.addGestureRecognizer(tapGesture)
//
//        relationPickerView.delegate = self
//        relationPickerView.dataSource = self
//    }
//
//    private func setupConstraints() {
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        contentView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalToSuperview()
//        }
//        avatarImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize(width: 100, height: 100))
//        }
//
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        nameTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(nameLabel)
//            make.left.equalTo(nameLabel.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(30)
//        }
//
//        idNumberLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        idNumberTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(idNumberLabel)
//            make.left.equalTo(idNumberLabel.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(30)
//        }
//
//        relationLabel.snp.makeConstraints { make in
//            make.top.equalTo(idNumberLabel.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        relationPickerView.snp.makeConstraints { make in
//            make.centerY.equalTo(relationLabel)
//            make.left.equalTo(relationLabel.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//        }
//
//        medicalHistoryLabel.snp.makeConstraints { make in
//            make.top.equalTo(relationLabel.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        medicalHistoryTextView.snp.makeConstraints { make in
//            make.top.equalTo(medicalHistoryLabel.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(100)
//        }
//
//        hospitalLabel.snp.makeConstraints { make in
//            make.top.equalTo(medicalHistoryTextView.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        hospitalTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(hospitalLabel)
//            make.left.equalTo(hospitalLabel.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(30)
//        }
//    }
//
//    // MARK: - Button Actions
//
//    @objc private func saveButtonPressed() {
//        // Perform save action here
//    }
//
//    // MARK: - Gesture Recognizer Actions
//
//    @objc private func avatarTapped() {
//        // Show image picker to select a new avatar image
//    }
//
//}
//
//// MARK: - UIPickerViewDataSource
//
//extension AddPersonViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 12
//    }
//}
//
//// MARK: - UIPickerViewDelegate
//
//extension AddPersonViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "(row + 1)"
//    }
//}
//
//

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    func addRequiredMark() {
        let label = UILabel()
        label.text = "*"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        addSubview(label)

        label.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.left).offset(-5)
        }
    }
}

//
//import UIKit
//import SnapKit
//
//class AddPersonViewController: BaseViewController {
//
//    // MARK: - Properties
//
//    var selectedImage: UIImage?
//
//    // MARK: - UI Elements
//
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = true
//        return scrollView
//    }()
//
//    private let contentView: UIView = {
//        let view = UIView()
//        return view
//    }()
//
//    private let avatarImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 50
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .gray
//        return imageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "就诊人姓名*"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "请输入就诊人姓名"
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let idNumberLabel: UILabel = {
//        let label = UILabel()
//        label.text = "身份证号*"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let idNumberTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "请输入身份证号"
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let relationLabel: UILabel = {
//        let label = UILabel()
//        label.text = "与就诊人关系*："
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let relationPickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        return pickerView
//    }()
//
//    private let medicalHistoryLabel: UILabel = {
//        let label = UILabel()
//        label.text = "病史描述"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let medicalHistoryTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.systemFont(ofSize: 16)
//        textView.layer.borderWidth = 1
//        textView.layer.borderColor = UIColor.lightGray.cgColor
//        return textView
//    }()
//
//    private let hospitalLabel: UILabel = {
//        let label = UILabel()
//        label.text = "默认医院"
//        label.font = UIFont.systemFont(ofSize: 16)
//        label.textColor = .black
//        return label
//    }()
//
//    private let hospitalTextField: UITextField = {
//        let textField = UITextField()
//        textField.text = "昆儿医院"
//        textField.isEnabled = false
//        textField.font = UIFont.systemFont(ofSize: 16)
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    // MARK: - Lifecycle Methods
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//        setupConstraints()
//    }
//
//    // MARK: - UI Setup Methods
//
//    private func setupUI() {
//        title = "添加就诊人"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonPressed))
//
//        scrollView.addSubview(contentView)
//        view.addSubview(scrollView)
//
//        contentView.addSubview(avatarImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(nameTextField)
//        contentView.addSubview(idNumberLabel)
//        contentView.addSubview(idNumberTextField)
//        contentView.addSubview(relationLabel)
//        contentView.addSubview(medicalHistoryLabel)
//        contentView.addSubview(medicalHistoryTextView)
//        contentView.addSubview(hospitalLabel)
//        contentView.addSubview(hospitalTextField)
//
//        // Add required marks
//        nameTextField.addRequiredMark()
//        idNumberTextField.addRequiredMark()
//        relationLabel.addRequiredMark()
//
//        // Set up avatar tap gesture recognizer
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
//        avatarImageView.isUserInteractionEnabled = true
//        avatarImageView.addGestureRecognizer(tapGesture)
//
//        // Set up picker view
//        relationPickerView.delegate = self
//        relationPickerView.dataSource = self
//
//        // Add Tap Gesture to relationLabel
//        let relationTapGesture = UITapGestureRecognizer(target: self, action: #selector(relationLabelTapped))
//        relationLabel.isUserInteractionEnabled = true
//        relationLabel.addGestureRecognizer(relationTapGesture)
//
//        // Hide the picker view initially
//        relationPickerView.isHidden = true
//
//        // Add the picker view to the content view
//        contentView.addSubview(relationPickerView)
//    }
//
//    private func setupConstraints() {
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//
//        contentView.snp.makeConstraints { make in
//            make.top.left.right.bottom.equalToSuperview()
//            make.width.equalToSuperview()
//        }
//
//        avatarImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(20)
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize(width: 100, height: 100))
//        }
//
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.width.equalTo(80)
//        }
//
//        nameTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(nameLabel)
//            make.left.equalTo(nameLabel.snp.right).offset(10)
//            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.height.equalTo(30)
//        }
//
//        idNumberLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(20)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.width.equalTo(80)
//        }
//
//        idNumberTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(idNumberLabel)
//            make.left.equalTo(idNumberLabel.snp.right).offset(10)
//            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.height.equalTo(30)
//        }
//
//        relationLabel.snp.makeConstraints { make in
//            make.top.equalTo(idNumberLabel.snp.bottom).offset(20)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.width.equalTo(120)
//        }
//
//        relationPickerView.snp.makeConstraints { make in
//            make.top.equalTo(relationLabel.snp.bottom)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(150)
//        }
//
//        medicalHistoryLabel.snp.makeConstraints { make in
//            make.top.equalTo(relationPickerView.snp.bottom).offset(20)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.width.equalTo(80)
//        }
//
//        medicalHistoryTextView.snp.makeConstraints { make in
//            make.top.equalTo(medicalHistoryLabel.snp.bottom).offset(10)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.height.equalTo(100)
//        }
//
//        hospitalLabel.snp.makeConstraints { make in
//            make.top.equalTo(medicalHistoryTextView.snp.bottom).offset(20)
//            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.width.equalTo(80)
//        }
//
//        hospitalTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(hospitalLabel)
//            make.left.equalTo(hospitalLabel.snp.right).offset(10)
//            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.height.equalTo(30)
//        }
//    }
//
//    // MARK: - Button Actions
//
//    @objc private func saveButtonPressed() {
//        // Perform save action here
//    }
//
//    // MARK: - Gesture Recognizer Actions
//
//    @objc private func avatarTapped() {
//        // Show image picker to select a new avatar image
//    }
//
//    @objc private func relationLabelTapped() {
//        self.relationPickerView.isHidden = false
//    }
//}
//
//// MARK: - UIPickerViewDataSource
//
//extension AddPersonViewController: UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 12
//    }
//}
//
//// MARK: - UIPickerViewDelegate
//
//extension AddPersonViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
////        return "(row + 1)"
//        return "\(row + 1)"
//    }
//}


//import UIKit
//import SnapKit
//
//class AddPersonViewController: BaseViewController {
//
//    // MARK: - Properties
//
//    private let nameLabel = UILabel()
//    private let nameTextField = UITextField()
//    private let idLabel = UILabel()
//    private let idTextField = UITextField()
//    private let relationshipLabel = UILabel()
//    private let relationshipPicker = UIPickerView()
//    private let historyLabel = UILabel()
//    private let historyTextView = UITextView()
//    private let hospitalId = "9ec744fb-fc2a-4589-94d1-5074c813bbdb"
//
//    private let relationships = ["", "父亲", "母亲", "儿子", "女儿", "祖父", "祖母", "外祖父", "外祖母", "兄弟", "姐妹", "其他"]
//
//    // MARK: - Lifecycle Methods
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//        setupConstraints()
//    }
//
//    // MARK: - Private Methods
//
//    private func setupUI() {
//        title = "添加就诊人"
//        view.backgroundColor = .white
//
//        nameLabel.text = "*姓名"
//        nameLabel.textColor = UIColor.red
//        nameLabel.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(nameLabel)
//
//        nameTextField.placeholder = "请输入姓名"
//        nameTextField.borderStyle = .roundedRect
//        nameTextField.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(nameTextField)
//
//        idLabel.text = "*身份证号"
//        idLabel.textColor = UIColor.red
//        idLabel.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(idLabel)
//
//        idTextField.placeholder = "请输入身份证号"
//        idTextField.borderStyle = .roundedRect
//        idTextField.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(idTextField)
//
//        relationshipLabel.text = "*与就诊人关系"
//        relationshipLabel.textColor = UIColor.red
//        relationshipLabel.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(relationshipLabel)
//
//        relationshipPicker.dataSource = self
//        relationshipPicker.delegate = self
//        view.addSubview(relationshipPicker)
//
//        historyLabel.text = "病史描述"
//        historyLabel.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(historyLabel)
//
//        historyTextView.layer.cornerRadius = 5
//        historyTextView.layer.borderWidth = 1
//        historyTextView.layer.borderColor = UIColor.lightGray.cgColor
//        historyTextView.font = UIFont.systemFont(ofSize: 15)
//        view.addSubview(historyTextView)
//    }
//
//    private func setupConstraints() {
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        nameTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(nameLabel)
//            make.left.equalTo(nameLabel.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//        }
//
//        idLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        idTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(idLabel)
//            make.left.equalTo(idLabel.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//        }
//
//        relationshipLabel.snp.makeConstraints { make in
//            make.top.equalTo(idLabel.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        relationshipPicker.snp.makeConstraints { make in
//            make.top.equalTo(relationshipLabel.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(120)
//        }
//
//        historyLabel.snp.makeConstraints { make in
//            make.top.equalTo(relationshipPicker.snp.bottom).offset(20)
//            make.left.equalToSuperview().offset(20)
//        }
//
//        historyTextView.snp.makeConstraints { make in
//            make.top.equalTo(historyLabel.snp.bottom).offset(10)
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(120)
//        }
//    }
//
//}
//
//// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
//
//extension AddPersonViewController: UIPickerViewDataSource, UIPickerViewDelegate {
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return relationships.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, title ForComponent component: Int) -> String? {
//        return relationships[component]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if relationships[row] != "" {
//            relationshipLabel.text = "*与就诊人关系"
//        } else {
//            relationshipLabel.text = "与就诊人关系"
//        }
//    }
//
//}




//import UIKit
//import SnapKit
//
//class AddPersonViewController: BaseViewController {
//
//    // MARK: - Properties
//
//    private let avatarImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .red
//        imageView.layer.cornerRadius = 50
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "姓名"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//
//    private let nameTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "请输入姓名"
//        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        textField.textColor = .black
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let idLabel: UILabel = {
//        let label = UILabel()
//        label.text = "身份证号"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//
//    private let idTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "请输入身份证号"
//        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        textField.textColor = .black
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let relationshipLabel: UILabel = {
//        let label = UILabel()
//        label.text = "与就诊人关系"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//
//    private let relationshipPickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        return pickerView
//    }()
//
//    private let medicalHistoryLabel: UILabel = {
//        let label = UILabel()
//        label.text = "病史描述"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//
//    private let medicalHistoryTextView: UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        textView.textColor = .black
//        textView.layer.borderWidth = 1
//        textView.layer.borderColor = UIColor.lightGray.cgColor
//        textView.layer.cornerRadius = 5
//        return textView
//    }()
//
//    private let defaultHospitalLabel: UILabel = {
//        let label = UILabel()
//        label.text = "默认医院"
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.textColor = .black
//        return label
//    }()
//
//    private let defaultHospitalTextField: UITextField = {
//        let textField = UITextField()
//        textField.text = "昆儿医院"
//        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        textField.textColor = .black
//        textField.borderStyle = .roundedRect
//        return textField
//    }()
//
//    private let confirmButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("确定", for: .normal)
//        button.backgroundColor = .red
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(confirm), for: .touchUpInside)
//        return button
//    }()
//
//    // MARK: - Lifecycle
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//
//        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    // MARK: - Selectors
//
//    @objc func confirm() {
//        // TODO: - 添加就诊人
//    }
//
//    // MARK: - Helpers
//
//    func configureUI() {
//        view.backgroundColor = .white
//
//        view.addSubview(avatarImageView)
//        avatarImageView.snp.makeConstraints { make in
//            make.centerX.equalTo(view)
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
//            make.width.height.equalTo(100)
//        }
//
//        view.addSubview(nameLabel)
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(avatarImageView.snp.bottom).offset(30)
//            make.left.equalTo(view).offset(20)
//            make.width.equalTo(80)
//        }
//
//        view.addSubview(nameTextField)
//        nameTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(nameLabel)
//            make.left.equalTo(nameLabel.snp.right).offset(20)
//            make.right.equalTo(view).offset(-20)
//            make.height.equalTo(30)
//        }
//
//        view.addSubview(idLabel)
//        idLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameLabel.snp.bottom).offset(30)
//            make.left.equalTo(view).offset(20)
//            make.width.equalTo(80)
//        }
//
//        view.addSubview(idTextField)
//        idTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(idLabel)
//            make.left.equalTo(idLabel.snp.right).offset(20)
//            make.right.equalTo(view).offset(-20)
//            make.height.equalTo(30)
//        }
//
//        view.addSubview(relationshipLabel)
//        relationshipLabel.snp.makeConstraints { make in
//            make.top.equalTo(idLabel.snp.bottom).offset(30)
//            make.left.equalTo(view).offset(20)
//            make.width.equalTo(80)
//        }
//
//        view.addSubview(relationshipPickerView)
//        relationshipPickerView.snp.makeConstraints { make in
//            make.centerY.equalTo(relationshipLabel)
//            make.left.equalTo(relationshipLabel.snp.right).offset(20)
//            make.right.equalTo(view).offset(-20)
//            make.height.equalTo(100)
//        }
//
//        view.addSubview(medicalHistoryLabel)
//        medicalHistoryLabel.snp.makeConstraints { make in
//            make.top.equalTo(relationshipLabel.snp.bottom).offset(30)
//            make.left.equalTo(view).offset(20)
//            make.width.equalTo(80)
//        }
//
//        view.addSubview(medicalHistoryTextView)
//        medicalHistoryTextView.snp.makeConstraints { make in
//            make.centerY.equalTo(medicalHistoryLabel)
//            make.left.equalTo(medicalHistoryLabel.snp.right).offset(20)
//            make.right.equalTo(view).offset(-20)
//            make.height.equalTo(100)
//        }
//
//        view.addSubview(defaultHospitalLabel)
//        defaultHospitalLabel.snp.makeConstraints { make in
//            make.top.equalTo(medicalHistoryLabel.snp.bottom).offset(30)
//            make.left.equalTo(view).offset(20)
//            make.width.equalTo(80)
//        }
//
//        view.addSubview(defaultHospitalTextField)
//        defaultHospitalTextField.snp.makeConstraints { make in
//            make.centerY.equalTo(defaultHospitalLabel)
//            make.left.equalTo(defaultHospitalLabel.snp.right).offset(20)
//            make.right.equalTo(view).offset(-20)
//            make.height.equalTo(30)
//        }
//
//        view.addSubview(confirmButton)
//        confirmButton.snp.makeConstraints { make in
//            make.centerX.equalTo(view)
//            make.top.equalTo(defaultHospitalLabel.snp.bottom).offset(50)
//            make.width.equalTo(200)
//            make.height.equalTo(50)
//        }
//    }
//}
//


import UIKit
import SnapKit
import SwiftyJSON

class AddPersonViewController: UIViewController {

    // MARK: - Properties

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "姓名"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入姓名"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "身份证号"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入身份证号"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let relationshipLabel: UILabel = {
        let label = UILabel()
        label.text = "与就诊人关系"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let relationshipPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()

    private let medicalHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "病史描述"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let medicalHistoryTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textView.textColor = .black
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        return textView
    }()

    private let defaultHospitalLabel: UILabel = {
        let label = UILabel()
        label.text = "默认医院"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let defaultHospitalTextField: UITextField = {
        let textField = UITextField()
        textField.text = "昆儿医院"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("确定", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        return button
    }()
    let hospitalId = "9ec744fb-fc2a-4589-94d1-5074c813bbdb"

    private let tapGesture: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        return gestureRecognizer
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTapGesture()
    }

    func validateIDNumber(_ idNumber: String) -> Bool {
//        let regex = "^\\\\d{17}([0-9xX])$"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        return predicate.evaluate(with: idNumber)
        let regex = "^\\d{17}([0-9xX])$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: idNumber)
    }

    
    // MARK: - Selectors

    @objc private func confirm() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showToast(message: "请输入姓名")
            return
        }
        guard let idNumber = idTextField.text, !idNumber.isEmpty else {
            showToast(message: "请输入身份证号")
            return
        }
        guard validateIDNumber(idNumber) else {
            showToast(message: "身份证号格式不正确")
            return
        }
        guard relationshipPickerView.selectedRow(inComponent: 0) != nil else {
            showToast(message: "请选择与就诊人的关系")
            return
        }
        
        
        let medicalHistory = medicalHistoryTextView.text ?? ""

        // TODO: - 添加就诊人
//        provider.request(.addPatientInfo(name: name, idCardNumber: idNumber, relation: "1", illnessDesc: medicalHistory, avatarUrl: "", isDefault: true, hospitalId: hospitalId)) { result in
//            switch result {
//            case let .success(response):
//                let data = response.data
//                let json = JSON(data)
//                // 解析json数据
//            case let .failure(error):
//                print(error)
//            }
//        }
        
        provider.request(.addPatientInfo(name: name, idCardNumber: idNumber, relation: "1", illnessDesc: medicalHistory, avatarUrl: "", isDefault: true, hospitalId: hospitalId)) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let json = JSON(data)
                if json["code"].intValue == 200 {
                    // 添加成功
                    DispatchQueue.main.async {
                        self.showToast(message: "添加成功")
                    }
                } else {
                    // 添加失败
                    DispatchQueue.main.async {
                        self.showToast(message: json["msg"].stringValue)
                    }
                }
            case let .failure(error):
                print(error)
            }
        }

    }

    private func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.numberOfLines = 0
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.alpha = 0.0
        view.addSubview(toastLabel)

        toastLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.lessThanOrEqualTo(250)
            make.height.greaterThanOrEqualTo(50)
        }

        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }, completion: { _ in
                toastLabel.removeFromSuperview()
            })
        })
    }
//    private func showToast(message: String) {
//        let toastLabel = UILabel()
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
//        toastLabel.textColor = UIColor.white
//        toastLabel.numberOfLines = 0
//        toastLabel.textAlignment = .center
//        toastLabel.font = UIFont.systemFont(ofSize: 14)
//        toastLabel.text = message
//        toastLabel.alpha = 0.0
//        view.addSubview(toastLabel)
//
//        toastLabel.snp.makeConstraints { make in
//            make.center.equalTo(view)
//            make.width.lessThanOrEqualTo(250)
//            make.height.greaterThanOrEqualTo(50)
//        }
//
//        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseOut, animations: {
//            toastLabel.alpha = 1.0
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
//                toastLabel.alpha = 0.0
//            }, completion: { _ in
//                toastLabel.removeFromSuperview()
//            })
//        })
//    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)

        containerView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView.snp.top).offset(50)
            make.width.height.equalTo(100)
        }

        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(30)
            make.left.equalTo(containerView).offset(20)
            make.width.equalTo(80)
        }

        containerView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.height.equalTo(30)
        }

        containerView.addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30)
            make.left.equalTo(containerView).offset(20)
            make.width.equalTo(80)
        }

        containerView.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            make.centerY.equalTo(idLabel)
            make.left.equalTo(idLabel.snp.right).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.height.equalTo(30)
        }

        containerView.addSubview(relationshipLabel)
        relationshipLabel.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(30)
            make.left.equalTo(containerView).offset(20)
            make.width.equalTo(80)
        }

        containerView.addSubview(relationshipPickerView)
        relationshipPickerView.snp.makeConstraints { make in
            make.centerY.equalTo(relationshipLabel)
            make.left.equalTo(relationshipLabel.snp.right).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.height.equalTo(100)
        }

        containerView.addSubview(medicalHistoryLabel)
        medicalHistoryLabel.snp.makeConstraints { make in
            make.top.equalTo(relationshipLabel.snp.bottom).offset(50)
            make.left.equalTo(containerView).offset(20)
            make.width.equalTo(80)
        }

        containerView.addSubview(medicalHistoryTextView)
        medicalHistoryTextView.snp.makeConstraints { make in
            make.centerY.equalTo(medicalHistoryLabel)
            make.left.equalTo(medicalHistoryLabel.snp.right).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.height.equalTo(80)
        }

        containerView.addSubview(defaultHospitalLabel)
        defaultHospitalLabel.snp.makeConstraints { make in
            make.top.equalTo(medicalHistoryLabel.snp.bottom).offset(50)
            make.left.equalTo(containerView).offset(20)
            make.width.equalTo(80)
        }

        containerView.addSubview(defaultHospitalTextField)
        defaultHospitalTextField.snp.makeConstraints { make in
            make.centerY.equalTo(defaultHospitalLabel)
            make.left.equalTo(defaultHospitalLabel.snp.right).offset(20)
            make.right.equalTo(containerView).offset(-20)
            make.height.equalTo(30)
        }

        containerView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(defaultHospitalLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.bottom.equalTo(containerView.snp.bottom).offset(-50)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
        }
    }

    private func configureTapGesture() {
        tapGesture.addTarget(self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
    }
}

