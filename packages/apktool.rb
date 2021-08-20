require 'package'

class Apktool < Package
  description 'A tool for reverse engineering Android apk files'
  homepage 'https://ibotpeaches.github.io/Apktool/'
  version '2.5.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'jdk8'

  def self.install
    system "curl -L#O https://raw.githubusercontent.com/iBotPeaches/Apktool/v#{version}/scripts/linux/apktool"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('apktool') ) == 'e9a49351b4df65d532e7c3cef27144c7e0e1c2daad1e367e65b2acef6715b863'
    system "curl -L#O https://github.com/iBotPeaches/Apktool/releases/download/v#{version}/apktool_#{version}.jar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("apktool_#{version}.jar") ) == 'b392d7cb99b592e9c5acc3c06f1b0f180edde96c66b86b3d6932b7c0c4079fe4'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install "apktool_#{version}.jar", "#{CREW_DEST_PREFIX}/bin/apktool.jar", mode: 0o644
    FileUtils.install 'apktool', "#{CREW_DEST_PREFIX}/bin/apktool", mode: 0o755
  end
end
