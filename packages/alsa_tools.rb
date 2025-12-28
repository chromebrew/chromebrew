require 'package'

class Alsa_tools < Package
  description 'The Advanced Linux Sound Architecture (ALSA) - tools'
  homepage 'https://github.com/alsa-project/alsa-tools'
  version '1.2.15'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/alsa-project/alsa-tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0371cbf52b671b2bc4fcfec6246fcfdcdec0ab795cb7c18c8eb4142c393a5e6e',
     armv7l: '0371cbf52b671b2bc4fcfec6246fcfdcdec0ab795cb7c18c8eb4142c393a5e6e',
     x86_64: '1d2ebf055aec3993d90fd6b1266849092d0898587bad672715287eb25f04aa91'
  })

  depends_on 'alsa_lib' # R
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'fltk' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'graphene' # R
  depends_on 'gtk4' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxcursor' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxrender' # R
  depends_on 'pango' # R
  depends_on 'vulkan_icd_loader' # R
  depends_on 'zlib' # R

  def self.patch
    # Make sure automake can be found.
    automake_libdir = `automake --print-libdir`.chomp
    system "find -name gitcompile -exec sed -i 's,/usr/local/share/automake,#{automake_libdir},' {} +"
    # Take out things that won't build.
    system "sed -i 's,ld10k1 qlo10k1,,' Makefile"
    system "sed -i 's,usx2yloader,,' Makefile"
    system "sed -i 's,hdspmixer,,' Makefile" if ARCH != 'x86_64'
  end

  def self.build
    system "GITCOMPILE_ARGS='--prefix=#{CREW_PREFIX}' make all"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
