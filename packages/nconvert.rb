require 'package'

class Nconvert < Package
  description 'Command Line Batch utility for images'
  homepage 'https://www.xnview.com/en/nconvert/'
  version '7.39'
  license 'NConvert-EULA'
  compatibility 'i686,x86_64'
  source_url({
    i686: 'https://download.xnview.com/NConvert-linux.tgz',
    x86_64: 'https://download.xnview.com/NConvert-linux64.tgz'
  })
  source_sha256({
    i686: '5e8364bdc1fe61d2c37871e0591ddc2048ccf0cd8041846b433ef04f10280cba',
    x86_64: '10f576609a982c9d7f4a519c9a49899609b63cea65d1a38b0c6f0c2fda2eb8c1'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'nconvert', "#{CREW_DEST_PREFIX}/bin/nconvert", mode: 0o755
  end
end
