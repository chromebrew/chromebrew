require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2018.03.20'
  source_url 'https://github.com/rg3/youtube-dl/releases/download/2018.03.20/youtube-dl-2018.03.20.tar.gz'
  source_sha256 'a977d04aa201ef35f8a6dc66b19204a9093b26c9d04d643089a1d467ba4e0682'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.03.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.03.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.03.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.03.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0fddeb1bb9e8032d393cb343277061d3b0be3dea42eff575d77524a959548014',
     armv7l: '0fddeb1bb9e8032d393cb343277061d3b0be3dea42eff575d77524a959548014',
       i686: '75dbe3fa49ab8ad2c2c4aae01bc173a39c687dfa6a476169d57f2b77bb7fd907',
     x86_64: '0c1a26f44ae3e0f8e23f69e6a2086619519e5f680a0f5b42b1aa5b591a77539c',
  })

  depends_on 'python27'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==2018.03.20"
    system "yes | pip uninstall setuptools"
  end
end
