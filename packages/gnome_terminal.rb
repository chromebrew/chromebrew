require 'package'

class Gnome_terminal < Package
  description 'The GNOME Terminal Emulator'
  homepage 'https://wiki.gnome.org/Apps/Terminal'
  @_ver = '3.41.0-3b79'
  version @_ver
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-terminal/-/archive/3b79354a357970147ae276a02ca2222db98a0d28/gnome-terminal-3b79354a357970147ae276a02ca2222db98a0d28.tar.bz2'
  source_sha256 'ad56dc0f1c6d75ed9ef6a1238e963141d7ba609ad3bffb376bfe43a37f0d308e'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gnome_terminal-3.41.0-3b79-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/gnome_terminal-3.41.0-3b79-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/gnome_terminal-3.41.0-3b79-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/gnome_terminal-3.41.0-3b79-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '127a7ebff88b54baca1e813e7a46b3b649e99e4c8395e47320ef9e534931d73a',
     armv7l: '127a7ebff88b54baca1e813e7a46b3b649e99e4c8395e47320ef9e534931d73a',
       i686: '8312ce51a47c2ced1d38700c18ade1ab65f471f989ac0d5336065865059e906a',
     x86_64: '7439c90a81a8ee6951021254a7d5ce1540b1aea95779fdcbf55ca507dbbd6cb6'
  })

  depends_on 'gtk3'
  depends_on 'vte'
  depends_on 'dconf'
  depends_on 'desktop_file_utilities'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'yelp_tools'
  depends_on 'gtk_doc'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    --default-library=both \
    -Dsearch_provider=false \
    -Dnautilus_extension=false \
    -Dc_args='-flto -fno-stack-protector -U_FORTIFY_SOURCE -fuse-ld=gold -pipe' \
    -Dcpp_args='-flto -fno-stack-protector -U_FORTIFY_SOURCE -fuse-ld=gold -pipe' \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
