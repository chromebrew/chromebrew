require 'package'

class Youtubedl < Package
  description 'Command-line program to download videos from YouTube.com and other video sites'
  homepage 'http://rg3.github.io/youtube-dl/'
  version '2018.09.18'
  source_url 'https://github.com/rg3/youtube-dl/releases/download/2018.09.18/youtube-dl-2018.09.18.tar.gz'
  source_sha256 '4b0f1365ce6bca66e99b83aa80e8098f04dd3a22d398e1b1eac3fbda5a6d9a56'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.09.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.09.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.09.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/youtubedl-2018.09.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ade342b4b5991a4e09893e3f5e5a598c0a1ee878ea74b94e60cd68cc5c17efb5',
     armv7l: 'ade342b4b5991a4e09893e3f5e5a598c0a1ee878ea74b94e60cd68cc5c17efb5',
       i686: 'ccbf5df99efb83dde40c8c96f1119f4fb3804f5246642fd62cd608208b54a699',
     x86_64: 'f83cc7215ebfa1cc792cac8f8f25eb07153446972b2aaffb0a347cf0397be5f1',
  })

  depends_on 'setuptools'

  def self.install
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I youtube-dl==2018.09.18"
  end
end
