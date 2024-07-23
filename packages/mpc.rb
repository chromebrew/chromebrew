require 'package'

class Mpc < Package
  description 'Gnu Mpc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result.'
  homepage 'https://www.multiprecision.org'
  version '1.2.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/mpc/mpc-1.2.1.tar.gz'
  source_sha256 '17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '51f7b0de3567634f42cb4e563520243cd6c9eca00b8efb1add25fbae97b286ce',
     armv7l: '51f7b0de3567634f42cb4e563520243cd6c9eca00b8efb1add25fbae97b286ce',
       i686: '63b012cdf4a7c8e1e948ceff325ea6dd476e2a4330462d1ce4b2778b51529ca9',
     x86_64: '57276bec912dabfed4d65d5edb3e18788c168056727057ee0c91aa8484eebdba'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R
  depends_on 'mpfr' # R

  def self.build
    system "./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-shared"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
