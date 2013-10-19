## Download và cài đặt ##
Download Cruisecontrolrb tại 

> https://github.com/thoughtworks/cruisecontrol.rb
 

Sau khi download về, giải nén ra ta được thư mục `cruisecontrol.rb-master`
Gõ lệnh:

    cd cruisecontrol.rb-master
    ./cruise start

để khởi động CruiseControl.

Mặc định CruiseControl sẽ khởi động ở localhost với port 3333
Bạn mở trình duyệt lên và truy cập vào địa chỉ `http://localhost:3333/`  Nếu hiện lên trang giao diện của CruiseControl là bạn đã thành công.

Để đưa một project vào trong quy trình Continuous Integration của CruiseControl ta gõ lệnh:

`cruise add [project-name] -r [repository] -s [svn|git|hg|bzr]`

Ví dụ, nếu bạn có một Project tên TestCruise, link trên github là git@github.com:michael/TestCruise.git thì gõ lệnh:

`cruise add TestCruise –r git@github.com:michael/TestCruise.git -s git`

## Config gửi mail từ tài khoản gmail ##
- Config email của developer thư được gửi đến

	Vào thư mục `\Users\YourName\.cruise\projects\YourProject` mở file `cruise_config.rb` chỉnh lại dòng:

	`project.email_notifier.emails = ['email1@your.site', 'email2@your.site']`

	trong đó trong dấu ngoặc [] là danh sách các email của developer mà bạn muốn thông báo kết quả build và test.

- Config để sử dụng tài khoản gmail để gửi mail

	Vào thư mục `:\Users\abc\.cruise` mở file `site_config.rb` thêm vào các dòng sau:
    
    	ActionMailer::Base.smtp_settings = {
    		:address =>"smtp.gmail.com",
    		:port =>   587,
    		:domain => "gmail.com",
    		:authentication => :plain,
    		:user_name =>  "yourgmailid@gmail.com",
    		:password =>   "yourpassword"
    	}
	Vậy là từ giờ mỗi khi build và test xong CruiseControl sẽ gửi mail báo kết quả về cho các Developer.

## Config để chạy lệnh build và test ##
Trong thư mục của project bạn tạo một file .sh, ví dụ `buildtest.sh`. Ngay khi bạn muốn đưa project vào quy trình CI hãy tạo file này.
Nếu đó là app Android thì nội dung của nó sẽ như sau:

    ant debug
    calabash-android run ./bin/YourProject-debug.apk
Dòng đầu tiên là lệnh build bằng ant phiên bản debug.
Dòng thứ hai là lệnh chạy test với Calabash-android.

Nếu đó là app iOS thì nội dung của nó sẽ như sau:

    xcodebuild build -workspace YourProject.xcworkspace –scheme YourProject-cal -configuration Debug -sdk iphonesimulator6.1 DEPLOYMENT_LOCATION=YES DSTROOT=build TARGETED_DEVICE_FAMILY=1
    cucumber
Dòng thứ nhất chứa lệnh build bằng XCode.
Dòng thứ hai chứa lệnh chạy test với Cucumber.

Sau đó hãy push file này lên git, CruiseControl sẽ phát hiện có thay đổi và sẽ pull về để build, nhưng vì chưa được config nên vẫn sẽ báo lỗi

Vào thư mục `\Users\YourName\.cruise\projects\YourProject` mở file `cruise_config.rb` chỉnh lại dòng:

    project.build_command = 'sh buildtest.sh'

trong đó `buildtest.sh` là file bạn đã tạo trong project ở trên.
 
Lưu lại thay đổi, CruiseControl sẽ phát hiện thay đổi trong file `cruise_config.rb` và lập tức build lại project.

**Lưu ý**: đối với Android, bạn phải chạy sẵn giả lập với lệnh `emulator –avd avdname` không thì lúc chạy test sẽ bị lỗi không tìm thấy thiết bị.
Còn với iOS thì server sẽ tự động mở emulator trước khi chạy test.

## Hướng dẫn chạy x-cross-platform example ##
Download 2 app mẫu về, giải nén ra, sau đó upload lên git của bạn. Tiến hành add 2 project vào CruiseControl như hướng dẫn bên trên. Sau đó config lại trong file `cruise_config.rb`:
Với project android sửa lại dòng:

    project.build_command = 'sh test_cruise_android.sh'

Với project iOS sửa lại dòng:

    project.build_command = 'sh test_cruise_ios.sh'

Những config khác của cruisecontrol giữ nguyên.



