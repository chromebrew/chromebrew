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
    aarch64: '53ca884b461b0e34612171b60c28b6838c9dc33ecb36c2d6da8befef1fba605b',
     armv7l: '53ca884b461b0e34612171b60c28b6838c9dc33ecb36c2d6da8befef1fba605b',
       i686: '5928cc1a9f8d2b2535f785f76e1547caf8991299aeeb847e7bd521aa973eea3e',
     x86_64: 'dc79411626db463321de78c38d06e9183bd1aea714082a944c4bc298aeb3146d'
  })

  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'libssh' # R
  depends_on 'libutempter' # R
  depends_on 'msgpack_c' # R
  depends_on 'ncurses' # R

  def self.patch
    # Patch for msgpack_c 6.x
    downloader 'https://github.com/tmate-io/tmate/pull/281.patch', '9f4f315a92b959606d42d672cf8c7312afaf4a93fba6c0e21bfee0b84e2d4667'
    system 'patch -p1 -i 281.patch'
  end

  pre_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncurses' CPPFLAGS='-I#{CREW_PREFIX}/include/ncurses'"
end
