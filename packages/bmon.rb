require 'buildsystems/autotools'

class Bmon < Autotools
  description 'bmon is a commandline bandwidth monitor and rate estimator.'
  homepage 'https://github.com/tgraf/bmon'
  version '4.0'
  license 'BSD-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/tgraf/bmon.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: '0184a21e121f2b1a5e11f45088bb87f467d8008e64bc619cce7512fe6ffa3b20',
     x86_64: '0190ef2ba6446bcaa28c9c0eae05e2569cedc1f2aacfafa96fc0f5d143b63414'
  })

  depends_on 'libconfuse'
  depends_on 'libnl3'
  depends_on 'ncurses'
  depends_on 'glibc' # R

  configure_options '--without-ncurses --with-ncursesw'
end
