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


import UIKit
import SnapKit

class AddPersonViewController: BaseViewController {
    
    // MARK: - Properties
    
    var selectedImage: UIImage?
    
    // MARK: - UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "就诊人姓名*"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入就诊人姓名"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let idNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "身份证号*"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let idNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入身份证号"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let relationLabel: UILabel = {
        let label = UILabel()
        label.text = "与就诊人关系*："
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let relationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let medicalHistoryLabel: UILabel = {
        let label = UILabel()
        label.text = "病史描述"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let medicalHistoryTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()
    
    private let hospitalLabel: UILabel = {
        let label = UILabel()
        label.text = "默认医院"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let hospitalTextField: UITextField = {
        let textField = UITextField()
        textField.text = "昆儿医院"
        textField.isEnabled = false
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup Methods
    
    private func setupUI() {
        title = "添加就诊人"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonPressed))
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextField)
        contentView.addSubview(idNumberLabel)
        contentView.addSubview(idNumberTextField)
        contentView.addSubview(relationLabel)
        contentView.addSubview(medicalHistoryLabel)
        contentView.addSubview(medicalHistoryTextView)
        contentView.addSubview(hospitalLabel)
        contentView.addSubview(hospitalTextField)
        
        // Add required marks
        nameTextField.addRequiredMark()
        idNumberTextField.addRequiredMark()
        relationLabel.addRequiredMark()
        
        // Set up avatar tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
        
        // Set up picker view
        relationPickerView.delegate = self
        relationPickerView.dataSource = self
        
        // Add Tap Gesture to relationLabel
        let relationTapGesture = UITapGestureRecognizer(target: self, action: #selector(relationLabelTapped))
        relationLabel.isUserInteractionEnabled = true
        relationLabel.addGestureRecognizer(relationTapGesture)
        
        // Hide the picker view initially
        relationPickerView.isHidden = true
        
        // Add the picker view to the content view
        contentView.addSubview(relationPickerView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(80)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        
        idNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(80)
        }
        
        idNumberTextField.snp.makeConstraints { make in
            make.centerY.equalTo(idNumberLabel)
            make.left.equalTo(idNumberLabel.snp.right).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
        
        relationLabel.snp.makeConstraints { make in
            make.top.equalTo(idNumberLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(120)
        }
        
        relationPickerView.snp.makeConstraints { make in
            make.top.equalTo(relationLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        medicalHistoryLabel.snp.makeConstraints { make in
            make.top.equalTo(relationPickerView.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(80)
        }
        
        medicalHistoryTextView.snp.makeConstraints { make in
            make.top.equalTo(medicalHistoryLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(100)
        }
        
        hospitalLabel.snp.makeConstraints { make in
            make.top.equalTo(medicalHistoryTextView.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(80)
        }
        
        hospitalTextField.snp.makeConstraints { make in
            make.centerY.equalTo(hospitalLabel)
            make.left.equalTo(hospitalLabel.snp.right).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(30)
        }
    }
    
    // MARK: - Button Actions
    
    @objc private func saveButtonPressed() {
        // Perform save action here
    }
    
    // MARK: - Gesture Recognizer Actions
    
    @objc private func avatarTapped() {
        // Show image picker to select a new avatar image
    }
    
    @objc private func relationLabelTapped() {
        self.relationPickerView.isHidden = false
    }
}

// MARK: - UIPickerViewDataSource

extension AddPersonViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 12
    }
}

// MARK: - UIPickerViewDelegate

extension AddPersonViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return "(row + 1)"
        return "\(row + 1)"
    }
}
