require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2019.08.02'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2019.08.02.tar.gz'
  source_sha256 '0c8e936d8212de803d1748aacd7559a6a91eb547de75c362c15db6cae4abcea1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==2019.08.02"
  end
end
