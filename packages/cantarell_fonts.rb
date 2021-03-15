require 'package'

class Cantarell_fonts < Package
  description 'Humanist sans serif font'
  homepage 'https://gitlab.gnome.org/GNOME/cantarell-fonts'
  @_ver = '0.301'
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/cantarell-fonts/#{@_ver}/cantarell-fonts-#{@_ver}.tar.xz"
  source_sha256 '3d35db0ac03f9e6b0d5a53577591b714238985f4cfc31a0aa17f26cd74675e83'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cantarell_fonts-0.301-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cantarell_fonts-0.301-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cantarell_fonts-0.301-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cantarell_fonts-0.301-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fb8107d41047d58c73a5c3152ed6319d5ce841a73f1f5d90d6bfff0c988ce9d7',
     armv7l: 'fb8107d41047d58c73a5c3152ed6319d5ce841a73f1f5d90d6bfff0c988ce9d7',
       i686: 'de3629bda1254054edcc86a50f50bf06f2d6bb258af6331850bdb862d37066d5',
     x86_64: '412ea866e38936691a7a16dcdd460a684e925007ed7fbb964eeb4c7c9873a4e9'
  })

  depends_on 'appstream_glib'
  depends_on 'fontconfig' => ':build'
  depends_on 'graphite' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Duseprebuilt=true \
      -Dfontsdir=#{CREW_PREFIX}/share/fonts/opentype/cantarell \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_PREFIX}/share/fonts/opentype/cantarell"
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "env FONTCONFIG_PATH=#{CREW_PREFIX}/etc/fonts fc-cache -fv || true"
  end
end
