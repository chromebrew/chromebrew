require 'package'

class Libxtst < Package
  description 'X.org Xtst Library'
  homepage 'http://t2sde.org/packages/libxtst.html'
  version '1.2.4'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://xorg.freedesktop.org/releases/individual/lib/libXtst-1.2.4.tar.xz'
  source_sha256 '84f5f30b9254b4ffee14b5b0940e2622153b0d3aed8286a3c5b7eeb340ca33c8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a44455fc4e851f8b7e876e158f4602fb10ab7181aad7813e484005121f31eae4',
     armv7l: 'a44455fc4e851f8b7e876e158f4602fb10ab7181aad7813e484005121f31eae4',
     x86_64: '2169135a37e04d3bcb39449423acbf56253a46bfa1bc08d204bf2a781e783c75'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxi' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
