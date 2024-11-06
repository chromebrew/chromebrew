require 'package'

class Nconvert < Package
  description 'Command Line Batch utility for images'
  homepage 'https://www.xnview.com/en/nconvert/'
  case ARCH
  when 'i686'
    version '7.39'
  when 'x86_64'
    version '7.192'
  end
  license 'NConvert-EULA'
  compatibility 'i686 x86_64'
  source_url({
    i686: 'https://download.xnview.com/old_versions/NConvert/NConvert-7.39-linux.tgz',
    x86_64: "https://download.xnview.com/old_versions/NConvert/NConvert-#{version}-linux64.tgz"
  })
  source_sha256({
    i686: '5e8364bdc1fe61d2c37871e0591ddc2048ccf0cd8041846b433ef04f10280cba',
    x86_64: '048c3c298acab62e05ad606f9a692748ff095f9034465932557da41f76b6827a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'nconvert', "#{CREW_DEST_PREFIX}/bin/nconvert", mode: 0o755
  end
end
