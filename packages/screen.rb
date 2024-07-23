require 'buildsystems/autotools'

class Screen < Autotools
  description 'Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.'
  homepage 'https://www.gnu.org/software/screen/'
  version '4.9.1'
  license 'public-domain'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/screen/screen-4.9.1.tar.gz'
  source_sha256 '26cef3e3c42571c0d484ad6faf110c5c15091fbf872b06fa7aa4766c7405ac69'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9281d8d1b1540edb54f5f4e66219c0c01c7176f7917dcc86b97e82a4031cb400',
     armv7l: '9281d8d1b1540edb54f5f4e66219c0c01c7176f7917dcc86b97e82a4031cb400',
       i686: 'b3bb9b631dc0ee96df7389b7167947e7df06cd9baeade0a174f88dc089bd1c36',
     x86_64: '833886ebe40348a53186205e4680d1c941d26d84964d35787f51720e82c2fa87'
  })

  depends_on 'ncurses' # R
  depends_on 'glibc' # R

  configure_options "--enable-colors256 CFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
end
