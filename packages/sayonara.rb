require 'buildsystems/cmake'

class Sayonara < CMake
  description 'Sayonara is a small, clear and fast audio player'
  homepage 'https://sayonara-player.com/'
  version '1.12.0-stable1'
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/luciocarreras/sayonara-player.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5400e95fcf3b637afef5101394837aea58f1aa1df09a8839295b63845d8d2c00',
     armv7l: '5400e95fcf3b637afef5101394837aea58f1aa1df09a8839295b63845d8d2c00',
     x86_64: 'ebdeb8120efe80926b5eb53cd9fcdcb21bf1025feb3027bd8039ac8d37a669d5'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'gstreamer' => :executable
  depends_on 'py3_dbus_python' => :executable
  depends_on 'qt5_base' => :executable
  depends_on 'qt5_svg' => :executable
  depends_on 'qt5_tools' => :executable
  depends_on 'taglib' => :executable
  depends_on 'utfcpp' => :executable
  depends_on 'zlib' => :executable

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/sayonara")
  end
end
