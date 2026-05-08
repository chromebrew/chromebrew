# Adapted from Arch Linux djvulibre PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/djvulibre/trunk/PKGBUILD

require 'buildsystems/autotools'

class Djvulibre < Autotools
  description 'Suite to create, manipulate and view DjVu déjà vu documents'
  homepage 'https://djvu.sourceforge.net/'
  version '3.5.30'
  license 'GPL2'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/djvu/DjVuLibre/#{version}/djvulibre-#{version}.tar.gz"
  source_sha256 'ee5e457d4cfebe566f94b99e5e3d3cc7f5c79ddb741c2ac2ba2e456f00329644'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1d04b1c42e9a5648a29701f2775e98d34438c62ff18195c467ece10f01230b1',
     armv7l: 'f1d04b1c42e9a5648a29701f2775e98d34438c62ff18195c467ece10f01230b1',
     x86_64: '857afb66dcafcf74104ff7ca6fbaac50b03623075f20e08c0b14c572f370b3c7'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'librsvg' => :build
  depends_on 'libtiff' => :executable

  autotools_configure_options '--disable-desktopfiles'

  autotools_install_extras do
    @desktopfiles = %w[22 32 48 64]
    @desktopfiles.each do |item|
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/hicolor/#{item}x#{item}/mimetypes"
      FileUtils.install "desktopfiles/prebuilt-hi#{item}-djvu.png",
                        "#{CREW_DEST_PREFIX}/share/icons/hicolor/#{item}x#{item}/mimetypes/image-vnd.djvu.mime.png", mode: 0o644
    end
  end
end
