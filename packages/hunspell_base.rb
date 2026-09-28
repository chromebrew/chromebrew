require 'buildsystems/autotools'

class Hunspell_base < Autotools
  description 'Hunspell is a spell checker and morphological analyzer library'
  homepage 'http://hunspell.github.io/'
  version '1.7.4'
  license 'MPL-1.1, GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/hunspell/hunspell.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22a170d9fa1358e045b3d715c6c0843a5f198dacec64c8097fbe5c53d748a1ca',
     armv7l: '22a170d9fa1358e045b3d715c6c0843a5f198dacec64c8097fbe5c53d748a1ca',
       i686: 'a7d5d81ca6f5898a44b1cf19b139362e36be852dc547c90d7ade12f2e4b02c1a',
     x86_64: 'a6b72e4f757ed5bff39b478d993b5c0d86903ecbbd6b14f7d50679187925f98d'
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
