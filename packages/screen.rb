require 'buildsystems/autotools'

class Screen < Autotools
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '5.0.3'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://git.savannah.gnu.org/git/screen.git'
  git_hashtag "v.#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f31e0d21ca776cdb865ae21f36d69c3cec5894797a7a905ef4c3199ab9c16431',
     armv7l: 'f31e0d21ca776cdb865ae21f36d69c3cec5894797a7a905ef4c3199ab9c16431',
       i686: 'acc9e2dd071cb67a74c3304e65d2f81c8cd32e193e16a08c8eb9c30dd3e4c9b7',
     x86_64: 'a62c63829fcf5c0861573ad3bbbab5ae38c9b7fe4796c8ea7df4e1fa539f192b'
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
