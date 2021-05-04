require 'package'

class Libheif < Package
  description 'libheif is a ISO/IEC 23008-12:2017 HEIF file format decoder and encoder.'
  homepage 'https://github.com/strukturag/libheif'
  @_ver = '1.11.0'
  version "#{@_ver}-2"
  license 'GPL-3'
  compatibility 'all'
  source_url "https://github.com/strukturag/libheif/releases/download/v#{@_ver}/libheif-#{@_ver}.tar.gz"
  source_sha256 'c550938f56ff6dac83702251a143f87cb3a6c71a50d8723955290832d9960913'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.11.0-2_armv7l/libheif-1.11.0-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.11.0-2_armv7l/libheif-1.11.0-2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.11.0-2_i686/libheif-1.11.0-2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libheif/1.11.0-2_x86_64/libheif-1.11.0-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '741663915e39e3f343c5d084423597484477eb49dc719f1395c62f84501ba8d9',
     armv7l: '741663915e39e3f343c5d084423597484477eb49dc719f1395c62f84501ba8d9',
       i686: '73ad610bbde6b2adb6ac5171efb9078e26ca9a252aece71688e5bd85b0478f86',
     x86_64: '00cdd26729e9af1d85ca26edd0094195cab10c53bb07158a892293ef94e033af'
  })

  depends_on 'dav1d'
  depends_on 'libaom'
  depends_on 'libde265'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libx265'
  depends_on 'rav1e'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    if File.exist?("#{CREW_PREFIX}/bin/gdk-pixbuf-query-loaders")
      system 'gdk-pixbuf-query-loaders',
             '--update-cache'
    end
  end
end
