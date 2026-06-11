require 'buildsystems/autotools'

class Hunspell_base < Autotools
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.3'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c225dcf41eca361066d3db5462061493e3593b17ac9780794cffa8985709060',
     armv7l: '4c225dcf41eca361066d3db5462061493e3593b17ac9780794cffa8985709060',
       i686: '6556856dec7e5426f8433e92d4883360a33e62e0e49d3d784131c5e30e914e31',
     x86_64: '5332efd061c450b1143447ac21899c878765a9da7e0a01c9f4f17d2fd15d2ce9'
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
