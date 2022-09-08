//
//  NFCtag.swift
//  Attendly2
//
//  Created by Rania Alageel on 12/02/1444 AH.
//


import SwiftUI
import CoreNFC

struct NFCtagView: View {
    @State var data = ""
    var body: some View {
        VStack {
        Text(data)
            nfcButton(data: self.$data)
        }
    }
}

struct NFCtagView_Previews: PreviewProvider {
    static var previews: some View {
        NFCtagView()
    }
}


struct nfcButton : UIViewRepresentable {
    @Binding var data :String
    func makeUIView(context: UIViewRepresentableContext<nfcButton>) -> UIButton {
        let button = UIButton()
        button.setTitle("Read NFC", for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.addTarget(context.coordinator, action: #selector(context.coordinator.beginScan(_sender:)), for: .touchUpInside)
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        // do nothing
    }
    
    func makeCoordinator() -> nfcButton.Coordinator {
        return Coordinator(data: $data)
    }
    
    class Coordinator : NSObject, NFCNDEFReaderSessionDelegate {
        var session : NFCNDEFReaderSession?
        @Binding var data : String
        
        init(data: Binding<String>){
            _data = data
        }
        
        @objc func beginScan(_sender: Any){
            guard NFCNDEFReaderSession.readingAvailable else {
                print("error: Scanning not support")
                return
            }
            
            session = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
            session?.alertMessage = "Hold your iphone near to scan."
            session?.begin()
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
            // check the validation
            if let readerError = error as? NFCReaderError {
                //
                //
                //
                //
                if (readerError.code != .readerSessionInvalidationErrorFirstNDEFTagRead)
                    && (readerError.code != .readerSessionInvalidationErrorUserCanceled) {
                    print("Error nfc read:\(readerError.localizedDescription)")
                }
            }
            
            // To read new tags , a new session instance is required.
            self.session = nil
        }
        
        func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
            guard
                let nfcMess = messages.first,
                let record = nfcMess.records.first,
                record.typeNameFormat == .absoluteURI || record.typeNameFormat == .nfcWellKnown,
                let payload = String(data: record.payload, encoding: .utf8)
            else{
                return
            }
            
            print(payload)
            self.data = payload
        }
        
        
    }
    
}
