require 'buildsystems/autotools'

class Screen < Autotools
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '5.0.1'
  license 'public-domain'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/screen/screen-#{version}.tar.gz"
  source_sha256 'f04a39d00a0e5c7c86a55338808903082ad5df4d73df1a2fd3425976aed94971'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '70b55809039f2642a261a258fb4bc212e2dda63f505152d097084535276a5ca3',
     armv7l: '70b55809039f2642a261a258fb4bc212e2dda63f505152d097084535276a5ca3',
       i686: '70da480de2fce8ad021059932d0d751d3fcc7bca894aeb656e362bbb871246de',
     x86_64: 'ec5956604dc25a310ce640c61ac49d35b50254219abb67d7e617fb5feb231606'
  })

  depends_on 'ncurses' # R
  depends_on 'glibc' # R

  configure_options "--enable-colors256 CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
