require 'package'

class Cantarell_fonts < Package
  description 'Humanist sans serif font'
  homepage 'https://gitlab.gnome.org/GNOME/cantarell-fonts'
  @_ver = '0.303.1'
  version @_ver
  license 'OFL-1.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/43/43.0/sources/cantarell-fonts-0.303.1.tar.xz'
  source_sha256 'f9463a0659c63e57e381fdd753cf1929225395c5b49135989424761830530411'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cantarell_fonts/0.303.1_armv7l/cantarell_fonts-0.303.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cantarell_fonts/0.303.1_armv7l/cantarell_fonts-0.303.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cantarell_fonts/0.303.1_i686/cantarell_fonts-0.303.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cantarell_fonts/0.303.1_x86_64/cantarell_fonts-0.303.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7a7bba136e7e7932c2b1c706b610707258c44b83656f54702d49a62b483c7e09',
     armv7l: '7a7bba136e7e7932c2b1c706b610707258c44b83656f54702d49a62b483c7e09',
       i686: 'cb44f16e43dfbcc8b2486e16366871986e82feafba6ef8c8f6c17a3fae982de7',
     x86_64: '6640502ffa69e9826def172ad79941dac5dd281138dbe7b2ba7f502ab50f2fad'
  })

  depends_on 'appstream_glib' => :build
  depends_on 'fontconfig' => :build
  depends_on 'graphite' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
