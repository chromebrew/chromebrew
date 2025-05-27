require 'buildsystems/cmake'

class Sayonara < CMake
  description 'Sayonara is a small, clear and fast audio player'
  homepage 'https://sayonara-player.com/'
  version '1.11.0'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/luciocarreras/sayonara-player.git'
  git_hashtag "#{version}-stable1"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89473c7e4d57d4ac2281dea6efafd110b99ec1ebc9e7188384d737d0777b8b79',
     armv7l: '89473c7e4d57d4ac2281dea6efafd110b99ec1ebc9e7188384d737d0777b8b79',
       i686: '47504fd456582c53a1e08b9dd4f74dcb8a828cd1926733d50b426f214074a0d8',
     x86_64: '060e38e12b1ddb75521ffbe4f51efa120d67faccbbc20346939e43f5a01d13d1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_svg' # R
  depends_on 'qt5_tools' # R
  depends_on 'taglib' # R
  depends_on 'utfcpp' # R
  depends_on 'zlib' # R

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/sayonara")
  end
end
