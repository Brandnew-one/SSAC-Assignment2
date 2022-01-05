//
//  Alert+Extension.swift
//  SeSACFarm
//
//  Created by 신상원 on 2022/01/05.
//

import Foundation
import UIKit

extension UIViewController {
    //수정 or 삭제를 선택할 수 있도록 설정
    func showActionSheet(deleteAction: @escaping () -> (), editAction: @escaping () -> () ) {
        
        let alert = UIAlertController(title: "삭제/수정", message: "삭제하거나 수정해보세요. ", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
            deleteAction()
        }
        let edit = UIAlertAction(title: "수정", style: .default) { _ in
            editAction()
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(delete)
        alert.addAction(edit)
        alert.addAction(cancle)
        
        self.present(alert, animated: true) {
            //print("액션시트가 올라왔습니다")
        }
    }
    
    func errorAlert(okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: "접근권한이 없습니다.", message: "작성한 ID가 다릅니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            okAction()
        }
        alert.addAction(ok)
        self.present(alert,animated: true) {
        }
    }
    
    
    func deleteAlert(okAction: @escaping () -> ()) {
        let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: "한번 더 생각해보세요. 되돌릴 수 없습니다!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            okAction()
        }
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancle)
        self.present(alert,animated: true)
    }
    
}
