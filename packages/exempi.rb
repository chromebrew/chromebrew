# Adapted from Arch Linux exempi PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/exempi/trunk/PKGBUILD

require 'package'

class Exempi < Package
  description 'A library to parse XMP metadata'
  homepage 'https://libopenraw.freedesktop.org/wiki/Exempi'
  @_ver = '2.6.3'
  version @_ver
  license 'BSD'
  compatibility 'all'
  source_url "https://gitlab.freedesktop.org/libopenraw/exempi/-/archive/#{@_ver}/exempi-#{@_ver}.tar.bz2"
  source_sha256 'e79995bb3c5319293e3f2abfc9da83a9ee5a83102724336599d535d874509632'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.3_armv7l/exempi-2.6.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.3_armv7l/exempi-2.6.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.3_i686/exempi-2.6.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/exempi/2.6.3_x86_64/exempi-2.6.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '60ae93ee0ae5c7edd00d3206dff793d5255436d37eb5bf118243bf7142393ac4',
     armv7l: '60ae93ee0ae5c7edd00d3206dff793d5255436d37eb5bf118243bf7142393ac4',
       i686: '5febec27428020406e8d6dd85abd5058cd2e72b47ee92dc28be7ea4997d6a29e',
     x86_64: '17a8c579b9a51f254476675b3d2bcdda6370fae697bf25da191f569321f7cd4e'
  })

  depends_on 'autoconf_archive' => :build
  depends_on 'boost' => :build
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
