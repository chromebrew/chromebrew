require 'package'

class Alsa_tools < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - tools'
  homepage 'https://github.com/alsa-project/alsa-tools'
  version '1.2.5'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/alsa-project/alsa-tools/archive/v1.2.5.tar.gz'
  source_sha256 'd38ef2a7582480eee31d7a7817810bc08969fd1cb045ef3b5443bda3e0df6e53'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_tools/1.2.5_armv7l/alsa_tools-1.2.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_tools/1.2.5_armv7l/alsa_tools-1.2.5-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/alsa_tools/1.2.5_x86_64/alsa_tools-1.2.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8e54c98dc073c5f5132135db778cfb1d4bc800dd033c4c7817984b8b85114178',
     armv7l: '8e54c98dc073c5f5132135db778cfb1d4bc800dd033c4c7817984b8b85114178',
     x86_64: '283ef086a574219f99f711890d9d184898b50478172d0ac48819aec33c92b4ce'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'fltk' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk2' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxrender' # R
  depends_on 'pango' # R
  depends_on 'zlibpkg' # R

  def self.patch
    # Make sure automake can be found.
    system "find -name gitcompile -exec sed -i 's,/usr/local/share/automake,#{CREW_PREFIX}/share/automake-1.16,' {} +"
    # Take out things that won't build.
    system "sed -i 's,ld10k1 qlo10k1,,' Makefile"
    system "sed -i 's,usx2yloader,,' Makefile"
    system "sed -i 's,hdspmixer,,' Makefile" if ARCH != 'x86_64'
  end

  def self.build
    system "GITCOMPILE_ARGS='--prefix=#{CREW_PREFIX}' mold -run make all"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
