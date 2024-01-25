require 'package'

class Libexif < Package
  description 'A library for parsing, editing, and saving EXIF data'
  homepage 'https://libexif.github.io/'
  version '0.6.22'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "https://github.com/libexif/libexif/releases/download/libexif-#{version.gsub(/[.]/, '_')}-release/libexif-#{version}.tar.xz"
  source_sha256 '5048f1c8fc509cc636c2f97f4b40c293338b6041a5652082d5ee2cf54b530c56'
  binary_compression 'tar.xz'

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
