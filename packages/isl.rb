require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.23'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'http://isl.gforge.inria.fr/isl-0.23.tar.xz'
  source_sha256 '5efc53efaef151301f4e7dde3856b66812d8153dede24fab17673f801c8698f2'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/isl/0.23_armv7l/isl-0.23-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/isl/0.23_armv7l/isl-0.23-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/isl/0.23_i686/isl-0.23-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/isl/0.23_x86_64/isl-0.23-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c552525f20ee4089d55c58cb718275ef8c5beba05f49dce6415de3a80983305e',
     armv7l: 'c552525f20ee4089d55c58cb718275ef8c5beba05f49dce6415de3a80983305e',
       i686: '84ea248c0a4994146fed949afe40b2b6395bda1466d50976f0b080751d7617e4',
     x86_64: '870574b61938cd278848864fd861a6d25ce27723375af17c3c3108fdc1197766'
  })

  depends_on 'glibc' # R
  depends_on 'gmp' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    # For backwards compatibility:
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libisl.so.23.0.0", "#{CREW_DEST_LIB_PREFIX}/libisl.so.15"
    FileUtils.ln_sf "#{CREW_LIB_PREFIX}/libisl.so.23.0.0", "#{CREW_DEST_LIB_PREFIX}/libisl.so.19"
  end
end
