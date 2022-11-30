require 'package'

class Apktool < Package
  description 'A tool for reverse engineering Android apk files'
  homepage 'https://ibotpeaches.github.io/Apktool/'
  version '2.7.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/iBotPeaches/Apktool/v2.7.0/scripts/linux/apktool'
  source_sha256 '84797978cbaf5f6cfee926ca55a5db710448b43a3e957567bd3e24feab41201e'

  depends_on 'openjdk8'

  def self.install
    downloader "https://github.com/iBotPeaches/Apktool/releases/download/v#{version}/apktool_#{version}.jar",
               'c11b5eb518d9ac2ab18e959cbe087499079072b04d567cdcae5ceb447f9a7e7d', 'apktool.jar'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'apktool.jar', "#{CREW_DEST_PREFIX}/bin", mode: 0o644
    FileUtils.install 'apktool', "#{CREW_DEST_PREFIX}/bin", mode: 0o755
  end
end
