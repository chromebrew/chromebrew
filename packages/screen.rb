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
       i686: '70da480de2fce8ad021059932d0d751d3fcc7bca894aeb656e362bbb871246de',
     x86_64: 'ec5956604dc25a310ce640c61ac49d35b50254219abb67d7e617fb5feb231606'
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
