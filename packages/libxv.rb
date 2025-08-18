require 'package'

class Libxv < Package
  description 'X.org X Window System video extension library'
  homepage 'https://www.x.org/wiki/'
  version '1.0.13'
  license 'X11'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxv.git'
  git_hashtag "libXv-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f3a7acfb6e130d46377102c2237e187db17bdbc48e48da2d0b4956960d1b01e',
     armv7l: '5f3a7acfb6e130d46377102c2237e187db17bdbc48e48da2d0b4956960d1b01e',
     x86_64: '993823a0e97e0288ba110da9cfb601e52f3cbe810c983629f160e3490ffebd75'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxext' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_CONFIGURE_OPTIONS} \
      --sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
