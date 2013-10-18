app_path = 'android-source/2.2.7/bin/Dashboard-debug.apk'
system("calabash-android run #{app_path} -p android #{ARGV.join(' ')}")
