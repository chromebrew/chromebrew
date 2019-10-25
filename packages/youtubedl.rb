require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2019.09.28'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2019.09.28.tar.gz'
  source_sha256 'bfeb2c7ccdb7d04bbbffd9aea75792a74e57f595bc73a29eca0fab6f4fa91a2b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.09.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.09.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.09.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2019.09.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2b883770f25cacf21a4bfd8a96458451fa330f0b391078af1a55b477a1938897',
     armv7l: '2b883770f25cacf21a4bfd8a96458451fa330f0b391078af1a55b477a1938897',
       i686: '23c26ea8cbe6cc0d6e7c45a28ff2d5464d8de9fbfe56245733e6c70510eb9a81',
     x86_64: '2ea5ffa227493593f1906bd3d29424788a4f764906f162dbe58905ec7df380a8',
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
