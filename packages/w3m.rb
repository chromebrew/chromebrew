# Does not build with GCC 15
require 'buildsystems/autotools'

class W3m < Autotools
  description 'w3m is a text-based browser, pager and HTML typesetter'
  homepage 'https://w3m.sourceforge.net/'
  version '0.5.6'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://git.sr.ht/~rkta/w3m/archive/v#{version}.tar.gz"
  source_sha256 '8dd652cd3f31817d68c7263c34eeffb50118c80be19e1159bf8cbf763037095e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90bf4c790e0f6fa58c2d537243257b121f8b833a376901077f9023c6fc892dec',
     armv7l: '90bf4c790e0f6fa58c2d537243257b121f8b833a376901077f9023c6fc892dec',
     x86_64: '56dd9fa77916ec1190b73662464371987dd59f31fd232682c62c9d3eb9939a4f'
  })

  depends_on 'bdwgc' => :library
  depends_on 'gdk_pixbuf'
  depends_on 'glibc' => :library
  depends_on 'gpm' => :executable
  depends_on 'imlib2' => :library
  depends_on 'libbsd' => :library
  depends_on 'libx11' => :library
  depends_on 'mailutils' => :build
  depends_on 'ncurses' => :executable
  depends_on 'openssl' => :executable
  depends_on 'zlib' => :library

  autotools_configure_options "--with-imagelib='gdk-pixbuf-2.0 imlib2' \
            --with-editor=$(which vi) \
            --with-mailer=$(which mail) \
            --with-ssl=#{CREW_PREFIX}/include/openssl \
            --with-termlib='terminfo mytinfo termcap tinfo ncurses curses'"
end
