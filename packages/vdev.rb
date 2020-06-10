require 'package'

class Vdev < Package
  description 'A device-file manager for *nix'
  homepage 'https://github.com/jcnelson/vdev'
  version 'ceb7a6c'
  compatibility 'all'
  source_url 'https://github.com/jcnelson/vdev/archive/ceb7a6c4f44dec542dc1c3c3d5abd27dec7f3e0e.tar.gz'
  source_sha256 'dbf561890aa70a8619506d166803a72d0c2a5b7590226feef784ec623bcb4739'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6c-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6c-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6c-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6c-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '087ab4f0a4b12f0fe49c8e0031e8af37b2b4e645cd71def45c212177716eaebb',
     armv7l: '087ab4f0a4b12f0fe49c8e0031e8af37b2b4e645cd71def45c212177716eaebb',
       i686: '7a9730d9c87a269e8f41adad59d55232b583614c7f11b9ce5472ed6fee7f4314',
     x86_64: 'f8384c3a8b057e48d13889a9ce8433b16d44f74a6750273323a53aa782bf24be',
  })

  depends_on 'fuse'
  depends_on 'libpstat'
  depends_on 'fskit'
  depends_on 'lvm2'

  def self.patch
    system "sed -i 's,-fstack-protector -fstack-protector-all ,,g' buildconf.mk libudev-compat/Makefile"
    system "sed -i 's,attr/xattr.h,sys/xattr.h,g' fs/fs.h"
  end

  def self.build
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX}"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} -C vdevd OS=LINUX"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} -C example"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} -C hwdb"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} -C libudev-compat"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} -C fs"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C vdevd OS=LINUX install"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C example install"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C hwdb install"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C libudev-compat install"
    system "make PREFIX=#{CREW_PREFIX} LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C fs install"
  end
end
