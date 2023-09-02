//
//  ViewController.swift
//  Chappago
//
//  Created by do hee kim on 2023/08/10.
//

import UIKit
import Alamofire

class TranslateViewController: UIViewController {
    
    let placeholderText = "번역할 내용을 입력하세요."
    
    var sourceLanguages: [Language] = Language.allCases
    var targetLanguages: [Language] = Language.ko.target
    
    var source: Language = .ko {
        didSet {
            sourceTextField.text = "\(source.text) ▼"
            
            targetLanguages = source.target
            target = source == .detect ? nil : targetLanguages[0]
            
            requestButton.setTitle("번역하기", for: .normal)
        }
    }
    var target: Language? = .en {
        didSet {
            guard let lang = target else {
                targetTextField.text = ""
                return
            }
            targetTextField.text = "\(lang.text) ▼"
        }
    }
    
    @IBOutlet var sourceView: UIView!
    @IBOutlet var originalTextView: UITextView!
    @IBOutlet var sourceTextField: UITextField!
    let sourcePickerView = UIPickerView()
    
    @IBOutlet var textLimitLabel: UILabel!
    
    @IBOutlet var requestButton: UIButton!
    
    @IBOutlet var targetView: UIView!
    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var targetTextField: UITextField!
    let targetPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func fetchDetectLanguage(text: String) {
        let url = "https://openapi.naver.com/v1/papago/detectLangs"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.Naver.ClientID,
            "X-Naver-Client-Secret": APIKey.Naver.ClientSecret
        ]
        let parameter: Parameters = [
            "query": text
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(Detector.self, from: data)
                    
                    guard let langCode = Language(rawValue: decodedData.langCode) else { return }
                    
                    self.source = langCode
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchTranslatedText(text: String) {
        guard let target = self.target else { return }
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.Naver.ClientID,
            "X-Naver-Client-Secret": APIKey.Naver.ClientSecret
        ]
        let parameter: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameter, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSONSerialization.data(withJSONObject: value)
                    let decodedData = try JSONDecoder().decode(Translator.self, from: data)
                    
                    self.translateTextView.text = decodedData.message.result.translatedText
                } catch {
                    print(error.localizedDescription, "ㅠㅠ")
                }
            case .failure(let error):
                print("ERROR!", error)
            }
        }
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func translateButtonClicked(_ sender: UIButton) {
        guard let text = originalTextView.text else { return }
        guard !text.isEmpty else { return }
        
        source != .detect ? fetchTranslatedText(text: text) : fetchDetectLanguage(text: text)
        
        view.endEditing(true)
    }
    
}

extension TranslateViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textLimitLabel.text = "\(textView.text.count)/5000"
    }
    
    // 글자수 제한
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (textView.text?.count ?? 0) +  (text.count - range.length) >= 5000 {
            return false
        }
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
}

extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1: return sourceLanguages.count
        case 2: return targetLanguages.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1: return sourceLanguages[row].text
        case 2: return targetLanguages[row].text
        default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            let pick = sourceLanguages[row]
            
            self.source = pick
            
            if pick == .detect {
                requestButton.setTitle("언어감지", for: .normal)
            }
        case 2: self.target = targetLanguages[row]
        default: print("default")
        }
    }
    
}

extension TranslateViewController {
    
    func configureUI() {
        configureView()
        configureTextField()
        configureButton()
        configurePicker()
        configureTextView()
    }
    
    func configureView() {
        setRoundBorder(view: sourceView)
        setRoundBorder(view: targetView)
    }
    
    func configureTextField() {
        sourceTextField.inputView = sourcePickerView
        sourceTextField.text = "\(source.text) ▼"
        setTextField(tf: sourceTextField)
        
        targetTextField.inputView = targetPickerView
        
        guard let target = self.target else { return }
        
        targetTextField.text = "\(target.text) ▼"
        setTextField(tf: targetTextField)
    }
    
    func configurePicker() {
        sourcePickerView.delegate = self
        sourcePickerView.dataSource = self
        sourcePickerView.tag = 1
        
        targetPickerView.delegate = self
        targetPickerView.dataSource = self
        targetPickerView.tag = 2
    }
    
    func configureTextView() {
        originalTextView.delegate = self
        
        originalTextView.text = placeholderText
        originalTextView.textColor = .lightGray

        originalTextView.font = UIFont.systemFont(ofSize: 20)
        translateTextView.font = UIFont.systemFont(ofSize: 20)
    }
    
    func configureButton() {
        requestButton.layer.cornerRadius = 10
    }
    
    func setTextField(tf: UITextField) {
        tf.tintColor = .clear
        tf.textAlignment = .right
    }
    
    func setRoundBorder(view: UIView) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        
        view.layer.cornerRadius = 10
    }
    
}
