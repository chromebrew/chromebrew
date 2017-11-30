require 'package'

class Vdev < Package
  description 'A device-file manager for *nix'
  homepage 'https://github.com/jcnelson/vdev'
  version 'ceb7a6'
  source_url 'https://github.com/jcnelson/vdev/archive/ceb7a6c4f44dec542dc1c3c3d5abd27dec7f3e0e.tar.gz'
  source_sha256 'dbf561890aa70a8619506d166803a72d0c2a5b7590226feef784ec623bcb4739'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf9bd2fdde42e0897e6aab47a18e2f2649b6dbd01de14bf6165c55c2a716e133',
     armv7l: 'bf9bd2fdde42e0897e6aab47a18e2f2649b6dbd01de14bf6165c55c2a716e133',
       i686: '8bb09676d68f9b00da89f0e9bc9499bc5d38332081cbbc698266f74644af89e1',
     x86_64: '45e3ca2fe33ec0dce519ad5053b63fefc4c50a38ce5fb842faca3ec941006f61',
  })

  depends_on 'glibc'
  depends_on 'fuse'
  depends_on 'libpstat'
  depends_on 'fskit'
  depends_on 'lvm2'

  def self.build
    system "make"
    system "make -C vdevd OS=LINUX"
    system "make -C example"
    system "make -C hwdb"
    system "make -C libudev-compat"
    system "make -C fs"
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
    system "make DESTDIR=#{CREW_DEST_DIR} -C vdevd OS=LINUX install"
    system "make DESTDIR=#{CREW_DEST_DIR} -C example install"
    system "make DESTDIR=#{CREW_DEST_DIR} -C hwdb install"
    system "make DESTDIR=#{CREW_DEST_DIR} -C libudev-compat install"
    system "make DESTDIR=#{CREW_DEST_DIR} -C fs install"
  end
end
