require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2020.12.14'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2020.12.14.tar.gz'
  source_sha256 '34f5f817bf82bb2f768bb3cf2460e7341e3df3cf8901ed00aebb9b97a308c980'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
