require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2019.10.29'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2019.10.29.tar.gz'
  source_sha256 'ac2ee960587c069efeda0322f3363ffe4b7b1fd5ad8cb7c35848eae11e767e75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.10.29-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.10.29-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.10.29-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.10.29-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72e9c612666916c70df7808ca57164d44723a6bcbf1f1b18e655d5b871cfd2f5',
     armv7l: '72e9c612666916c70df7808ca57164d44723a6bcbf1f1b18e655d5b871cfd2f5',
       i686: '3983aa6b74d962316c445224cd6ac0aa3d8756d6351a7c5ab5f9a4222d9dd0ca',
     x86_64: 'f82524ea792a08abc14c17837cdbf82a05d004829413aee1f2e70bf7cce75acb',
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
