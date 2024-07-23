require 'package'

class Alsa_tools < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - tools'
  homepage 'https://github.com/alsa-project/alsa-tools'
  version '1.2.11'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/alsa-project/alsa-tools/archive/v1.2.11.tar.gz'
  source_sha256 '0b6fc23b57a853a2cb283f1816bb0bc6b4da4ebdfff27c37b6f79b1f0f4f29e2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e22e1948652e91d03ee0f037e675057a5a6e2968a839c416c4b111f2e3a5d319',
     armv7l: 'e22e1948652e91d03ee0f037e675057a5a6e2968a839c416c4b111f2e3a5d319',
     x86_64: 'e9b741eb7af82b10bc62376bbd21c0624f3eaedc4dbd37b1da519a89892bc14b'
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
