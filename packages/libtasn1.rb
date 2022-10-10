require 'package'

class Libtasn1 < Package
  description 'Libtasn1 is the ASN.1 library used by GnuTLS, GNU Shishi and some other packages.'
  homepage 'https://www.gnu.org/software/libtasn1/'
  version '4.17'
  license 'GPL-3 and LGPL-2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libtasn1/libtasn1-4.17.0.tar.gz'
  source_sha256 'ece7551cea7922b8e10d7ebc70bc2248d1fdd73351646a2d6a8d68a9421c45a5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtasn1/4.17_armv7l/libtasn1-4.17-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtasn1/4.17_armv7l/libtasn1-4.17-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtasn1/4.17_i686/libtasn1-4.17-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libtasn1/4.17_x86_64/libtasn1-4.17-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4705282fadb02d1220ce050cf3236f537daf1925de0c0d8b1b781f9512bd564c',
     armv7l: '4705282fadb02d1220ce050cf3236f537daf1925de0c0d8b1b781f9512bd564c',
       i686: 'b11e71ef0e5972523eb9b3a940607603c7eb248f6e2b40b8cf25f9dc634a4020',
     x86_64: '45bb14fceafe35899eb7d379a6c61347428f7acaca451dc24798eb463939e898'
  })

  # bison, diff, cmp are required at compile-time
  depends_on 'bison' => :build
  depends_on 'diffutils' => :build
  depends_on 'glibc' # R

  def self.build
    system "./configure #{CREW_OPTIONS} \
      #{CREW_ENV_OPTIONS} \
      --enable-shared \
      --enable-static \
      --with-pic"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
