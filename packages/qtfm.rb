require 'buildsystems/cmake'

class Qtfm < Cmake
  description 'Lightweight desktop independent Qt file manager'
  homepage 'https://qtfm.eu/'
  version '6.3.0-c19b9c1-2'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/rodlie/qtfm.git'
  git_hashtag 'c19b9c14d1afde8558c912b17497dd2c34c971ef'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtfm/6.3.0-c19b9c1-1_armv7l/qtfm-6.3.0-c19b9c1-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtfm/6.3.0-c19b9c1-1_armv7l/qtfm-6.3.0-c19b9c1-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtfm/6.3.0-c19b9c1-1_x86_64/qtfm-6.3.0-c19b9c1-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '414ca7a9d1e42424456dd0c8f32abcda0e3e9b6fee193fc51f89e45ad1413f68',
     armv7l: '414ca7a9d1e42424456dd0c8f32abcda0e3e9b6fee193fc51f89e45ad1413f68',
     x86_64: '2a83b6944bd9e04a655afc1c5789b2cbad676e3b78440ab1a0c325ad74e72aa1'
  })

  depends_on 'ffmpeg' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R

  def self.patch
    system "sed -i '12i#include <QPainterPath>' libfm/iconlist.h"
    system "sed -i '14i#include <QPainterPath>' libfm/iconview.h"
  end

  cmake_options '-DENABLE_DBUS=OFF \
        -DENABLE_FFMPEG=ON \
        -DENABLE_MAGICK=OFF \
        -DENABLE_TRAY=OFF \
        -DENABLE_UDISKS=OFF'
end
