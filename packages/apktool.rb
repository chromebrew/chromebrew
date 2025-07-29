require 'package'

class Apktool < Package
  description 'A tool for reverse engineering Android apk files'
  homepage 'https://apktool.org/'
  version '2.12.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://raw.githubusercontent.com/iBotPeaches/Apktool/v#{version}/scripts/linux/apktool"
  source_sha256 '493a9c98df968a25c373ca9df871ca77730c82954be4959b74e90adaf91a0e77'

  depends_on 'openjdk8'

  no_compile_needed

  def self.install
    downloader "https://github.com/iBotPeaches/Apktool/releases/download/v#{version}/apktool_#{version}.jar",
               'effb69dab2f93806cafc0d232f6be32c2551b8d51c67650f575e46c016908fdd', 'apktool.jar'
    FileUtils.install 'apktool.jar', "#{CREW_DEST_PREFIX}/bin/apktool.jar", mode: 0o644
    FileUtils.install 'apktool', "#{CREW_DEST_PREFIX}/bin/apktool", mode: 0o755
  end
end
