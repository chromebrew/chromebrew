require 'package'

class Csvkit < Package
  description 'A suite of utilities for converting to and working with CSV, the king of tabular file formats.'
  homepage 'http://csvkit.rtfd.org/'
  version '1.0.2'
  source_url 'https://github.com/wireservice/csvkit/archive/1.0.2.tar.gz'
  source_sha256 '35c8c7c699573bec47cbd3576240cc9b444d35f309386f8030340bc50315cdec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/csvkit-1.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '206f49dd91cb59644fdde836b8db80fb87dd0d3520ea649ef8dfee987866979c',
     armv7l: '206f49dd91cb59644fdde836b8db80fb87dd0d3520ea649ef8dfee987866979c',
       i686: '66168c87db16a7495df6199d80e2903e0a101f5e8078ffa5d396a91e6df3016e',
     x86_64: '3160e34cf8c24f7c3d6e68a8220071f327fa446e7669d90c9d76f24e515fdcb2',
  })

  depends_on 'python27'

  def self.install
    system "yes | pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -r requirements-py2.txt -r requirements-py3.txt csvkit"
    system "yes | pip uninstall setuptools"
  end
end
