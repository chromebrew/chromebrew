require 'package'

class Android_sdk_tools < Package
  description 'Android SDK CLI tools'
  homepage 'https://developer.android.com/studio'
  version '7583922'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip'
  source_sha256 '124f2d5115eee365df6cf3228ffbca6fc3911d16f8025bebd5b1c6e2fcfa7faf'

  depends_on 'jdk11'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/android-sdk-tools"
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/android-sdk-tools"
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
