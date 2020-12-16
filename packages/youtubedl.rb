require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2020.12.14'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/archive/2020.12.14.tar.gz'
  source_sha256 '34f5f817bf82bb2f768bb3cf2460e7341e3df3cf8901ed00aebb9b97a308c980'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2020.12.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2020.12.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2020.12.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2020.12.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dcb6599df3d676da65a142510428e4f05eda6c1d713d02eefe9024f26f51b78d',
     armv7l: 'dcb6599df3d676da65a142510428e4f05eda6c1d713d02eefe9024f26f51b78d',
       i686: '0b80c2458c82cf40365ec8c1080e44accd065feb1a7c212db2603fc3af3a8e76',
     x86_64: 'c1a343feeb52cb380eea8b134799d69d690fcea4103272c0c5c5a79f93e872e7',
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
