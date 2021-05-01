require 'package'

class Libgdiplus < Package
  description 'The mono library that provides a GDI+-compatible API on non-windows operating systems.'
  homepage 'https://www.mono-project.com/docs/gui/libgdiplus/'
  version '6.0.5-3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://download.mono-project.com/sources/libgdiplus/libgdiplus-6.0.5.tar.gz'
  source_sha256 'b81e4e5cc3e4831b2945de08bef26eb1bdcd795aeaf8f971b221c51213a025ef'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-3_armv7l/libgdiplus-6.0.5-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-3_armv7l/libgdiplus-6.0.5-3-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-3_i686/libgdiplus-6.0.5-3-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libgdiplus/6.0.5-3_x86_64/libgdiplus-6.0.5-3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b8567295afed609d49bed5ecf8ccd9b363cfdb453afc1028ee8afd3a00e348b7',
     armv7l: 'b8567295afed609d49bed5ecf8ccd9b363cfdb453afc1028ee8afd3a00e348b7',
       i686: '889b8b69cb691d00f5b506d3f2770cb172c9a1ad8ddc0441a82d3d77e971fa79',
     x86_64: '9c4f2e47dc4f95c88a188838cef7a5424fd272177d8eb4a7d32dfbeb212fc0b6'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'giflib'
  depends_on 'glib'
  depends_on 'graphite'
  depends_on 'imake' => :build
  depends_on 'libexif'
  depends_on 'libjpeg'
  depends_on 'libpng'
  depends_on 'libtiff'
  depends_on 'libwebp'

  def self.build
    system "CFLAGS='-flto=auto' CXXFLAGS='-flto=auto'
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --with-libexif \
      --with-libtiff \
      --with-jpeg \
      --with-libgif \
      --with-x11"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
