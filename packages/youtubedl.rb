require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'https://youtube-dl.org/'
  version '2021.01.08'
  compatibility 'all'
  source_url 'https://github.com/ytdl-org/youtube-dl/releases/download/2021.01.08/youtube-dl-2021.01.08.tar.gz'
  source_sha256 '7340448a90ac82dfb2b1b6569f08bd87552b9b1647a81eb735e11dd6d30607cd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.01.08-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.01.08-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.01.08-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2021.01.08-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1427981aaedea3633c0a0e3ba7ef75dd3d9c3b351b10f1a60a5bdd72acc603cf',
     armv7l: '1427981aaedea3633c0a0e3ba7ef75dd3d9c3b351b10f1a60a5bdd72acc603cf',
       i686: 'b8a8c7f46c6f32c34c029661b0e2f052afbe68d16b9e52461067af6ae29868b5',
     x86_64: '58e230678b46d8ea61f5c1e884ef0779dbbc3237bae4b04ef34c33e7f3fcd524',
  })

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==#{version}"
  end
end
