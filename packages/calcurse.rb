require 'buildsystems/autotools'

class Calcurse < Autotools
  description 'calcurse is a calendar and scheduling application for the command line.'
  homepage 'https://calcurse.org/'
  version '4.8.2'
  license 'BSD-2'
  compatibility 'all'
  source_url "https://calcurse.org/files/calcurse-#{version}.tar.gz"
  source_sha256 'aa36a434752e4c6df86ce1bb7b223e041afc9bdce056abd3c2e65389d412e872'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f00dd8d36b1d82a6e37677152a04e2d3ad5f773daae23aecc29d9216a77a701',
     armv7l: '2f00dd8d36b1d82a6e37677152a04e2d3ad5f773daae23aecc29d9216a77a701',
       i686: '0c68f3c1c6635e2cc5e3697cb308384f9774c5228d1eb15a331739ac97e07ee7',
     x86_64: 'e1e4f34a76ff7c641348db5aa1ef74adee5122331b5bc4e0c9ccfc5fe80c95ad'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
