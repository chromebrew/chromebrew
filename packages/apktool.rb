require 'package'

class Apktool < Package
  description 'A tool for reverse engineering Android apk files'
  homepage 'https://ibotpeaches.github.io/Apktool/'
  version '2.6.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'jdk8'

  def self.install
    downloader "https://raw.githubusercontent.com/iBotPeaches/Apktool/v#{version}/scripts/linux/apktool",
               '84797978cbaf5f6cfee926ca55a5db710448b43a3e957567bd3e24feab41201e'
    downloader "https://github.com/iBotPeaches/Apktool/releases/download/v#{version}/apktool_#{version}.jar",
               'bc2b9a87ac5a86905b6ca343c21a0db3bc37bdd51154bc9cdf65523d95895d34'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install "apktool_#{version}.jar", "#{CREW_DEST_PREFIX}/bin/apktool.jar", mode: 0o644
    FileUtils.install 'apktool', "#{CREW_DEST_PREFIX}/bin/apktool", mode: 0o755
  end
end
