# Adapted from Arch Linux tmate PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/tmate/trunk/PKGBUILD

require 'buildsystems/autotools'

class Tmate < Autotools
  description 'Instant terminal sharing'
  homepage 'https://tmate.io/'
  version '2.4.0-ac91951'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/tmate-io/tmate.git'
  git_hashtag 'ac919516f4f1b10ec928e20b3a5034d18f609d68'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9484bfb931621e2b63c1d5b6401ba47336df5b0fb363020918749439b00cba2c',
     armv7l: '9484bfb931621e2b63c1d5b6401ba47336df5b0fb363020918749439b00cba2c',
       i686: '12821785cd37aee98841d606fc68cb7958454f3e0a9aedce8d795c3176e13218',
     x86_64: '52c51e577c993bb4dcee5f1191bc73e442ffe27fc2ba83b4674bda1f4936bbcb'
  })

  depends_on 'libevent' => :build
  depends_on 'libssh' => :build
  depends_on 'libutempter' => :build
  depends_on 'msgpack_c' => :build
  depends_on 'ncurses' => :build
  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'libssh' # R
  depends_on 'libutempter' # R
  depends_on 'msgpack_c' # R
  depends_on 'ncurses' # R
  depends_on 'libevent' # R
  depends_on 'libssh' # R
  depends_on 'libutempter' # R
  depends_on 'msgpack_c' # R
  depends_on 'ncurses' # R

  def self.patch
    # Patch for msgevent_c 6.x
    downloader 'https://github.com/tmate-io/tmate/pull/281.patch', '9f4f315a92b959606d42d672cf8c7312afaf4a93fba6c0e21bfee0b84e2d4667'
    system 'patch -p1 -i 281.patch'
  end

  pre_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncurses' CPPFLAGS='-I#{CREW_PREFIX}/include/ncurses'"
end
