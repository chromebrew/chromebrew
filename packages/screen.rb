require 'buildsystems/autotools'

class Screen < Autotools
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '5.0.2'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/screen.git'
  git_hashtag "v.#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b4e9708194cb19cad6082e6d2e34e9d378638ba6aa379d35924f8834742fbf6d',
     armv7l: 'b4e9708194cb19cad6082e6d2e34e9d378638ba6aa379d35924f8834742fbf6d',
       i686: '7742eae113ef5f0991c0a6792c12a0f8c4a307407e4ef4def4ddd1d085053e62',
     x86_64: '661ab943c92c456b3427e8e2bf484b19a46d6d9283ac54f4f63713017f91f643'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'linux_pam' => :executable
  depends_on 'ncurses' => :executable

  autotools_configure_options "--enable-colors256 CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"

  def self.prebuild
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' mktar.pl"
    system './mktar.pl'
    system "tar fx screen-#{version}.tar.gz --strip-components=1"
  end
end
