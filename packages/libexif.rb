require 'package'

class Libexif < Package
  description 'A library for parsing, editing, and saving EXIF data'
  homepage 'https://libexif.github.io/'
  @_ver = '0.6.22'
  @_ver_ = @_ver.gsub(/[.]/, '_')
  version @_ver
  compatibility 'all'
  source_url "https://github.com/libexif/libexif/releases/download/libexif-#{@_ver_}-release/libexif-#{@_ver}.tar.xz"
  source_sha256 '5048f1c8fc509cc636c2f97f4b40c293338b6041a5652082d5ee2cf54b530c56'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.22-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.22-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libexif-0.6.22-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '4294ea1bb5c87281c0033466c28213309c29888b7b38dc31ca7952399eb05bf1',
     armv7l: '4294ea1bb5c87281c0033466c28213309c29888b7b38dc31ca7952399eb05bf1',
       i686: '0065d20692bdf287574972b3e4f3b03d18c63e4cfdc53196565d75d977132afd',
     x86_64: 'd8d0f76f087122ac63d088ec1233e45f6b88880f80ab08bea72f2461bd4e2aa4'
  })

  def self.build
    system 'autoreconf -i -f'
    system "sed -i '69,70d' po/Makefile.in.in"
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
     --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
