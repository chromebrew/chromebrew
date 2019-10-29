require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2019.10.29'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2019.10.29.tar.gz'
  source_sha256 'ac2ee960587c069efeda0322f3363ffe4b7b1fd5ad8cb7c35848eae11e767e75'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
