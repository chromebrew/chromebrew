require 'package'

class Android_sdk_tools < Package
  description 'Android SDK Command-Line Tools'
  homepage 'https://developer.android.com/studio'
  version '16111833'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://dl.google.com/android/repository/commandlinetools-linux-#{version}_latest.zip"
  source_sha256 '0877a1d048fe4a24efe2eff536ca4223f7adeb58648bb81909d33c446918cfa8'

  depends_on 'openjdk17'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/android-sdk-tools"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/android-sdk-tools"
    Dir["#{CREW_DEST_PREFIX}/share/android-sdk-tools/bin/*"].each do |filename|
      binary = File.basename(filename)
      FileUtils.ln_s "../share/android-sdk-tools/bin/#{binary}", "#{CREW_DEST_PREFIX}/bin/#{binary}"
    end
  end

  def self.postinstall
    puts "\nThe available tools are listed below:".lightblue
    system "ls #{CREW_PREFIX}/share/android-sdk-tools/bin"
  end
end
