# Adapted from Arch Linux djvulibre PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/djvulibre/trunk/PKGBUILD

require 'package'

class Djvulibre < Package
  description 'Suite to create, manipulate and view DjVu déjà vu documents'
  homepage 'http://djvu.sourceforge.net/'
  version '3.5.28'
  license 'GPL2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/djvu/DjVuLibre/#{version}/djvulibre-#{version}.tar.gz"
  source_sha256 'fcd009ea7654fde5a83600eb80757bd3a76998e47d13c66b54c8db849f8f2edc'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/djvulibre-3.5.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/djvulibre-3.5.28-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/djvulibre-3.5.28-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/djvulibre-3.5.28-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2a662b5b95e3e5c24531cb4ae0f5b33c044895f33fc88c562026a4124ff15295',
     armv7l: '2a662b5b95e3e5c24531cb4ae0f5b33c044895f33fc88c562026a4124ff15295',
       i686: 'a0cf591f8e04fc89a0c2f45f0ad67c7c907971dcf85371a2184c3ea54e605da4',
     x86_64: 'd17ec121e01aea869ea74b421aebcf4b8f019e8b32268859256aadd32019aab5'
  })
 
  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'librsvg' => :build

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-desktopfiles"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    @desktopfiles = %w[22 32 48 64]
    @desktopfiles.each do |item|
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/hicolor/#{item}x#{item}/mimetypes"
      FileUtils.install "desktopfiles/prebuilt-hi#{item}-djvu.png",
                        "#{CREW_DEST_PREFIX}/share/icons/hicolor/#{item}x#{item}/mimetypes/image-vnd.djvu.mime.png", mode: 0o644
    end
  end
end
