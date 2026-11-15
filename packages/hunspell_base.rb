require 'buildsystems/autotools'

class Hunspell_base < Autotools
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.6'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce0988a828bf57a6b1d9793009371625cb682bebd86fd29f45b3e6f9e1117c76',
     armv7l: 'ce0988a828bf57a6b1d9793009371625cb682bebd86fd29f45b3e6f9e1117c76',
       i686: '7d70a2852cae64b6ae6b7a627b5b1d83a4b70691c5c3639b2e321f1ee596334f',
     x86_64: '94e413626723b22b60d784a79323c1ab2559f89dc305f803a2f62a5c648bb281'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ncurses' => :library
  depends_on 'readline' => :executable

  def self.patch
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' man/hunspell.1"
    system "sed -i 's,/usr/share,#{CREW_PREFIX}/share,g' src/tools/hunspell.cxx"
    system "sed -i 's,ncurses.h,#{CREW_PREFIX}/include/ncursesw/ncurses.h,' src/tools/hunspell.cxx"
  end

  autotools_pre_configure_options "CPPFLAGS+=' -I#{CREW_PREFIX}/include -I#{CREW_PREFIX}/include/ncursesw -I#{CREW_PREFIX}/include/ncurses '"
  autotools_configure_options '--with-ui --with-readline'

  autotools_install_extras do
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{CREW_DEST_PREFIX}/bin/ispellaff2myspell"
  end
end
