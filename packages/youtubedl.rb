require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2019.09.28'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2019.09.28.tar.gz'
  source_sha256 'bfeb2c7ccdb7d04bbbffd9aea75792a74e57f595bc73a29eca0fab6f4fa91a2b'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
