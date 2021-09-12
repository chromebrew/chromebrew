require 'package'

class Apktool < Package
  description 'A tool for reverse engineering Android apk files'
  homepage 'https://ibotpeaches.github.io/Apktool/'
  version '2.6.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'jdk8'

  def self.install
    system "curl -L#O https://raw.githubusercontent.com/iBotPeaches/Apktool/v#{version}/scripts/linux/apktool"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('apktool') ) == '84797978cbaf5f6cfee926ca55a5db710448b43a3e957567bd3e24feab41201e'
    system "curl -L#O https://github.com/iBotPeaches/Apktool/releases/download/v#{version}/apktool_#{version}.jar"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read("apktool_#{version}.jar") ) == 'f750a3cd2c1f942f27f5f7fd5d17eada3bdaff0a6643f49db847e842579fdda5'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install "apktool_#{version}.jar", "#{CREW_DEST_PREFIX}/bin/apktool.jar", mode: 0o644
    FileUtils.install 'apktool', "#{CREW_DEST_PREFIX}/bin/apktool", mode: 0o755
  end
end
