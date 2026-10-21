class AppCopy {
  const AppCopy({required this.english});

  final bool english;

  String get accounts => english ? 'Accounts' : 'အကောင့်';
  String get settings => english ? 'Settings' : 'ဆက်တင်';
  String get language => english ? 'Language' : 'ဘာသာစကား';
  String get myanmar => english ? 'Myanmar' : 'မြန်မာ';
  String get themeColor => english ? 'Color' : 'အရောင်';
  String get appearance => english ? 'Appearance' : 'ပုံစံ';
  String get light => english ? 'Light' : 'အလင်း';
  String get system => english ? 'System' : 'စနစ်အတိုင်း';
  String get dark => english ? 'Dark' : 'အမှောင်';
  String get policy => english ? 'Policy' : 'မူဝါဒ';
  String get report => english ? 'Report to developer' : 'ဆော့ဖ်ဝဲရေးသူထံ တင်ပြမည်';
  String get profile => english ? 'Profile' : 'ကိုယ်ရေးအချက်';
  String get shopName => english ? 'Shop name' : 'ဆိုင်အမည်';
  String get save => english ? 'Save' : 'သိမ်းမည်';
  String get add => english ? 'Add' : 'ထည့်မည်';
  String get edit => english ? 'Edit' : 'ပြင်မည်';
  String get delete => english ? 'Delete' : 'ဖျက်မည်';
  String get name => english ? 'Name' : 'အမည်';
  String get role => english ? 'Role' : 'အခန်းကဏ္ဍ';
  String get owner => english ? 'Owner' : 'ပိုင်ရှင်';
  String get cashier => english ? 'Cashier' : 'အရောင်း';
  String get pin => english ? 'PIN' : 'လျှို့ဝှက်နံပါတ်';
  String get loginAllowed => english ? 'Can sign in' : 'ဝင်ရောက်ခွင့်';
  String get allowed => english ? 'Allowed' : 'ဝင်ခွင့်ရှိ';
  String get blocked => english ? 'Blocked' : 'ပိတ်ထား';
  String get users => english ? 'Users' : 'အသုံးပြုသူ';
  String get newUser => english ? 'New user' : 'အကောင့်အသစ်';
  String get editUser => english ? 'Edit user' : 'အကောင့်ပြင်မည်';
  String get pinHint => english ? '4 digits. Leave blank to keep the current PIN.' : 'ဂဏန်း ၄ လုံး။ မပြောင်းလျှင် အလွတ်ထားပါ။';
  String get pinRequired => english ? 'Enter a 4-digit PIN.' : 'ဂဏန်း ၄ လုံးထည့်ပါ။';
  String get pinUsed => english ? 'That PIN is already used.' : 'ဒီနံပါတ်ကို သုံးပြီးသားဖြစ်သည်။';
  String get nameRequired => english ? 'Enter a name.' : 'အမည်ထည့်ပါ။';
  String get keepOwner => english ? 'Keep one owner who can sign in.' : 'ဝင်ခွင့်ရှိသော ပိုင်ရှင်တစ်ယောက်ချန်ထားပါ။';
  String get saveFailed => english ? 'Could not save.' : 'သိမ်းမရပါ။';
  String get deleteUser => english ? 'Delete this user?' : 'ဒီအကောင့်ကို ဖျက်မည်လား။';
  String get cancel => english ? 'Cancel' : 'မလုပ်တော့ပါ';
  String get home => english ? 'Home' : 'ပင်မ';
  String get choose => english ? 'Choose one.' : 'လုပ်ဆောင်ချက်တစ်ခုကို ရွေးချယ်ပါ။';
  String get sale => english ? 'Sale' : 'အရောင်း';
  String get saleList => english ? 'Sale list' : 'အရောင်းစာရင်း';
  String get purchases => english ? 'Purchases' : 'အဝယ်';
  String get products => english ? 'Products' : 'ကုန်ပစ္စည်း';
  String get prices => english ? 'Selling price' : 'ရောင်းဈေး';
  String get categories => english ? 'Categories' : 'အမျိုးအစား';
  String get damage => english ? 'Damage' : 'ပျက်စီး';
  String get expenses => english ? 'Expenses' : 'အသုံးစရိတ်';
  String get stock => english ? 'Stock' : 'လက်ကျန်';
  String get stockReport => english ? 'Stock report' : 'လက်ကျန်အစီရင်ခံစာ';
  String get daily => english ? 'Daily summary' : 'နေ့စဉ်စာရင်း';
  String get policyBody => english
      ? 'Sales, stock, and staff stay on this register. A PIN is required to sign in. Turn off “Can sign in” to block a user without deleting their past sales.'
      : 'အရောင်း၊ လက်ကျန်နှင့် အကောင့်များသည် ဒီစက်ထဲမှာပဲ ရှိသည်။ ဝင်ရန် လျှို့ဝှက်နံပါတ် လိုသည်။ အကောင့်မဖျက်ဘဲ ဝင်ခွင့်ကို ပိတ်နိုင်သည်။';
  String get reportHint => english ? 'Describe the problem.' : 'ပြဿနာကို ရေးပါ။';
  String get reportSaved => english ? 'Saved on this register.' : 'ဒီစက်မှာ သိမ်းပြီးပါပြီ။';
  String get noReports => english ? 'No reports yet.' : 'တင်ပြချက်မရှိသေးပါ။';
  String get shopHint => english ? 'This name shows on the register.' : 'ဒီအမည်ကို မှတ်ပုံတင်ဘားမှာ ပြသည်။';
  String get cloud => english ? 'Data sync' : 'ဒေတာချိတ်မည်';
  String get cloudWaiting => english ? 'Waiting to send' : 'ပို့ရန်';
  String get cloudNone => english ? 'Nothing waiting.' : 'ပို့ရန်မရှိပါ။';
  String get cloudHint => english
      ? 'The number is how many rows are waiting. When this Mac is online, click Data sync.'
      : 'ဂဏန်းသည် ပို့ရန်ကျန်သည့် အရေအတွက်ဖြစ်သည်။ အွန်လိုင်းဖြစ်မှ ဒေတာချိတ်မည် ကို နှိပ်ပါ။';
  String get cloudOnce => english
      ? 'Enter these once. After that, only click Data sync.'
      : 'ဒီနှစ်ခုကို တစ်ကြိမ်သာ ထည့်ပါ။ နောက်ပိုင်း ဒေတာချိတ်မည် ကို နှိပ်ရုံပါ။';
  String get cloudUrl => english ? 'Project URL' : 'ပရောဂျက်လိပ်စာ';
  String get cloudKey => 'Publishable key';
  String get cloudSend => english ? 'Data sync' : 'ဒေတာချိတ်မည်';
  String get cloudSent => english ? 'Sent.' : 'ပို့ပြီးပါပြီ။';
  String get cloudMissing => english ? 'Enter the URL and the publishable key once.' : 'လိပ်စာနှင့် key ကို တစ်ကြိမ် ထည့်ပါ။';
  String get cloudBadUrl => english ? 'The URL must start with https://' : 'လိပ်စာသည် https:// ဖြင့် စရမည်။';
  String get cloudSecret => english ? 'Paste the publishable key. Leave the secret key in Supabase.' : 'publishable key ကို ထည့်ပါ။ secret key ကို Supabase မှာပဲ ထားပါ။';
  String get cloudOffline => english ? 'Offline. The waiting number stays until you are online.' : 'အော့ဖ်လိုင်းဖြစ်နေသည်။ အွန်လိုင်းဖြစ်မှ ပို့နိုင်သည်။';
  String get cloudChange => english ? 'Change connection' : 'ချိတ်ဆက်မှု ပြင်မည်';
}
