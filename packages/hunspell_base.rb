require 'buildsystems/autotools'

class Hunspell_base < Autotools
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.5'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '213e45f3e4fa20c111c7cbbead7cd14f48bfacd051ced0e9d8c39d046b89cb84',
     armv7l: '213e45f3e4fa20c111c7cbbead7cd14f48bfacd051ced0e9d8c39d046b89cb84',
       i686: 'f3200a29b03e980146ca0acaea098fb11cf9ef91bca5a9807a3058e9e4a434d9',
     x86_64: 'abc8cdb0015b5cfa452525a5b8d75193f31188dc332a8b9b29eaca0c2e473257'
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
