require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  version '2021.02.10'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/releases/download/2021.02.10/youtube-dl-2021.02.10.tar.gz'
  source_sha256 'd607adf66b7047865733f7d05af9478118ee4dd974ef9f971563e11de7f29122'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.02.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.02.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.02.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.02.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '595afef841f6baf7d61cbea4956804e010c1f34c15a631534fb069d113794301',
     armv7l: '595afef841f6baf7d61cbea4956804e010c1f34c15a631534fb069d113794301',
       i686: '7f5d197be7122f5a63e9cd4ed4f3450b1c61ff256b7b190cd4f059f3dbd5fab6',
     x86_64: 'f03d9b99696b5a93be0a1f14271e90ed8ee1029b3d104e7b1d4be3af1b9a044d',
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version} --no-warn-script-location"
  end
end
