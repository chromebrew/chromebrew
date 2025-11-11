require 'buildsystems/autotools'

class Hunspell_base < Autotools
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.2'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8c4db6f90ce30d23c176dc7eb8453ac91253fc181d763cb0f614fbb7bf59544',
     armv7l: 'c8c4db6f90ce30d23c176dc7eb8453ac91253fc181d763cb0f614fbb7bf59544',
       i686: 'e18ba0d501eec99d78a57667be100f9c7406edbcff9297534769ff10dea5dda1',
     x86_64: '58fe35f3257cfba2233b0c3259b583d81cb59a4003ab1d0b6283300f198034bf'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
  depends_on 'readline'

  def self.patch
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' man/hunspell.1"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' src/tools/hunspell.cxx"
    system "sed -i 's,ncurses.h,#{CREW_PREFIX}/include/ncursesw/ncurses.h,' src/tools/hunspell.cxx"
  end

  autotools_pre_configure_options "CPPFLAGS+=' -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I#{CREW_PREFIX}/include/ncurses '"
  autotools_configure_options '--with-ui --with-readline'
end
