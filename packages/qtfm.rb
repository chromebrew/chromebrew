require 'package'

class Qtfm < Package
  description 'Lightweight desktop independent Qt file manager'
  homepage 'https://qtfm.eu/'
  version '6.3.0-c19b9c1'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/rodlie/qtfm.git'
  git_hashtag 'c19b9c14d1afde8558c912b17497dd2c34c971ef'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtfm/6.3.0-c19b9c1_armv7l/qtfm-6.3.0-c19b9c1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtfm/6.3.0-c19b9c1_armv7l/qtfm-6.3.0-c19b9c1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtfm/6.3.0-c19b9c1_x86_64/qtfm-6.3.0-c19b9c1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '77291ef1b43542d0b6269428c7d7c4cbd0d900d0ae34c2f80d95a4a58e16e0db',
     armv7l: '77291ef1b43542d0b6269428c7d7c4cbd0d900d0ae34c2f80d95a4a58e16e0db',
     x86_64: '7de70548f891d644236d84e53ba08b4dbb48fadd9c92977c419205a999da83f9'
  })

  depends_on 'ffmpeg' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'imagemagick7' # R
  depends_on 'qtbase' # R

  def self.patch
    system "sed -i '12i#include <QPainterPath>' libfm/iconlist.h"
    system "sed -i '14i#include <QPainterPath>' libfm/iconview.h"
  end

  def self.build
    system "mold -run cmake -B builddir #{CREW_CMAKE_OPTIONS} \
        -DENABLE_DBUS=OFF \
        -DENABLE_FFMPEG=ON \
        -DENABLE_MAGICK=ON \
        -DENABLE_TRAY=OFF \
        -DENABLE_UDISKS=OFF \
        -Wno-dev \
        -G Ninja"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
