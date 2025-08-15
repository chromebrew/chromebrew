require 'buildsystems/meson'

class V4l_utils < Meson
  description 'The v4l-utils are a series of packages for handling media devices.'
  homepage 'https://www.linuxtv.org/wiki/index.php/V4l-utils'
  version '1.30.1'
  license 'GPL-2+ and LGPL-2.1+'
  compatibility 'all'
  source_url 'https://git.linuxtv.org/v4l-utils.git'
  git_hashtag "v4l-utils-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f9649d3b4ab8bad29abc672da5aaecd451a011a1b53f302b0f1edb0350ae387',
     armv7l: '6f9649d3b4ab8bad29abc672da5aaecd451a011a1b53f302b0f1edb0350ae387',
       i686: 'b0ff283ea4749e07c74d5a7923b1a1247795546f9af78ba1e0c91962ad32c386',
     x86_64: '9abf83c04426cae26ef5eccdd1c238fdb6d1c8f6e8d49e965a76ac0f336d1314'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libjpeg_turbo'

  def self.patch
    system "find . -name '*.pl' -exec sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' {} +"
  end
end
