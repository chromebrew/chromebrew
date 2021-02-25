require 'package'

class Libwmf < Package
  description 'libwmf is a library for reading vector images in Microsoft\'s native Windows Metafile Format (WMF)'
  homepage 'https://github.com/caolanm/libwmf'
  version '0.2.12-ffc8'
  compatibility 'all'
  source_url 'https://github.com/caolanm/libwmf/archive/ffc8f5aaf9ac33d5d2fe67e777c018e057fdfd71.zip'
  source_sha256 'cdde9db1a0bc22a529f55aa60c2c7b85d1adb1e16e15b1d0b8906c04667b851a'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-ffc8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-ffc8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-ffc8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libwmf-0.2.12-ffc8-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e8d5f598473faae411a33090c9275ef725e90a8011cc0c30cc81e5aff694b7e0',
     armv7l: 'e8d5f598473faae411a33090c9275ef725e90a8011cc0c30cc81e5aff694b7e0',
       i686: '54e66e41849070b245879b1d30ab2ca3382a113e13715d9b20a1adf7b7f14ded',
     x86_64: '4f23adf6e1093f7cb21f3d651f393df955ad06a6bf6c78937394dbf4da153677'
  })

  depends_on 'gtk2'
  depends_on 'libgd'
  depends_on 'libjpeg'
  depends_on 'xorg_server'
  depends_on 'gdk_pixbuf'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    system 'gdk-pixbuf-query-loaders --update-cache'
  end
end
