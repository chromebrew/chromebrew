require 'package'

class Android_sdk_tools < Package
  description 'Android SDK CLI tools'
  homepage 'https://developer.android.com/studio'
  version '13114758'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://dl.google.com/android/repository/commandlinetools-linux-#{version}_latest.zip"
  source_sha256 '7ec965280a073311c339e571cd5de778b9975026cfcbe79f2b1cdcb1e15317ee'

  depends_on 'openjdk17'

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
    puts "\nTesting binaries...".yellow
    Dir["#{CREW_PREFIX}/share/android-sdk-tools/bin/*"].each do |bin|
      puts "\nTesting #{bin}...".yellow
      system "#{bin} --help;exit 0"
    end
    puts "\nThe available tools are listed below:".lightblue
    system "ls #{CREW_PREFIX}/share/android-sdk-tools/bin"
  end
end
