# Does not build with GCC 15
require 'buildsystems/autotools'

class W3m < Autotools
  description 'w3m is a text-based browser, pager and HTML typesetter'
  homepage 'https://w3m.sourceforge.net/'
  version '0.5.3+git20230121'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/tats/w3m.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '26d2ec1ac94fb70d22fe9ad1046c518eb01ba34049d7768f7ade530fa6fdfc9a',
     armv7l: '26d2ec1ac94fb70d22fe9ad1046c518eb01ba34049d7768f7ade530fa6fdfc9a',
     x86_64: '8158b705233aded5ed349fe830f17a6d1eaf128632c8e609b06ce14bb05a16a7'
  })

  depends_on 'bdwgc' # R
  depends_on 'gdk_pixbuf'
  depends_on 'glibc' # R
  depends_on 'gpm' # R
  depends_on 'imlib2' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'mailutils' => :build
  depends_on 'ncurses' # R
  depends_on 'openssl' # R
  depends_on 'zlib' # R

  autotools_configure_options "--with-imagelib='gdk-pixbuf-2.0 imlib2' \
            --with-editor=$(which vi) \
            --with-mailer=$(which mail) \
            --with-ssl=#{CREW_PREFIX}/include/openssl \
            --with-termlib='terminfo mytinfo termcap tinfo ncurses curses'"
end
