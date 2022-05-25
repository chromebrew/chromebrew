# Adapted from Arch Linux djvulibre PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/djvulibre/trunk/PKGBUILD

require 'package'

class Djvulibre < Package
  description 'Suite to create, manipulate and view DjVu déjà vu documents'
  homepage 'http://djvu.sourceforge.net/'
  @_ver = '3.5.28'
  version "#{@_ver}-1"
  license 'GPL2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/djvu/DjVuLibre/#{@_ver}/djvulibre-#{@_ver}.tar.gz"
  source_sha256 'fcd009ea7654fde5a83600eb80757bd3a76998e47d13c66b54c8db849f8f2edc'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/djvulibre/3.5.28-1_armv7l/djvulibre-3.5.28-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/djvulibre/3.5.28-1_armv7l/djvulibre-3.5.28-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/djvulibre/3.5.28-1_i686/djvulibre-3.5.28-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/djvulibre/3.5.28-1_x86_64/djvulibre-3.5.28-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '48a4422a5608c30ca64ee39e5def5889b39fb0a8baa21bea2e4a1a71732e4807',
     armv7l: '48a4422a5608c30ca64ee39e5def5889b39fb0a8baa21bea2e4a1a71732e4807',
       i686: '72dc698bb4e83cfa4b745005daea4ab7f877477e307462df26940b0404bb851c',
     x86_64: '2d7e552fb69f2f0065b149be8046aaed7e6db3094b1f827fdd24454c2d5ddc9a'
  })

  depends_on 'libjpeg'
  depends_on 'libtiff'
  depends_on 'librsvg' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
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
