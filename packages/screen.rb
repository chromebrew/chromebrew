require 'buildsystems/autotools'

class Screen < Autotools
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '5.0.1'
  license 'GPL-3+'
  compatibility 'all'
  source_url "https://git.savannah.gnu.org/cgit/screen.git/snapshot/screen-v.#{version}.tar.gz"
  source_sha256 'e90c84930a439b005cce01f76f13e30a4947efe4f4421acd37f02951c6bcab9d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70b55809039f2642a261a258fb4bc212e2dda63f505152d097084535276a5ca3',
     armv7l: '70b55809039f2642a261a258fb4bc212e2dda63f505152d097084535276a5ca3',
       i686: 'e5ebb986ea1e1d1ba5b4e36da6b8948e3f697cee109e870564a472d4e1ade607',
     x86_64: '7c3d258a354d407120a67e8a075c1365e48cce382ea5581b7b3ae9fbba0cad79'
  })

  depends_on 'glibc' # R
  depends_on 'libxcrypt' # R
  depends_on 'linux_pam' # R
  depends_on 'ncurses' # R

  configure_options "--enable-colors256 CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"

  def self.prebuild
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' mktar.pl"
    system './mktar.pl'
    system "tar fxv screen-#{version}.tar.gz --strip-components=1"
  end
end
