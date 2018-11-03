require 'package'

class Vdev < Package
  description 'A device-file manager for *nix'
  homepage 'https://github.com/jcnelson/vdev'
  version 'ceb7a6c'
  source_url 'https://github.com/jcnelson/vdev/archive/ceb7a6c4f44dec542dc1c3c3d5abd27dec7f3e0e.tar.gz'
  source_sha256 'dbf561890aa70a8619506d166803a72d0c2a5b7590226feef784ec623bcb4739'

  binary_url ({
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vdev-ceb7a6c-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '826658f93e7a9c31eda6adfc1d96f9e1ded2c8becf4bbc0a8315ba4e6a77da3f',
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
    system "make LIBDIR=#{CREW_LIB_PREFIX}"
    system "make LIBDIR=#{CREW_LIB_PREFIX} -C vdevd OS=LINUX"
    system "make LIBDIR=#{CREW_LIB_PREFIX} -C example"
    system "make LIBDIR=#{CREW_LIB_PREFIX} -C hwdb"
    system "make LIBDIR=#{CREW_LIB_PREFIX} -C libudev-compat"
    system "make LIBDIR=#{CREW_LIB_PREFIX} -C fs"
  end

  def self.install
    system "make LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} install"
    system "make LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C vdevd OS=LINUX install"
    system "make LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C example install"
    system "make LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C hwdb install"
    system "make LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C libudev-compat install"
    system "make LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR} -C fs install"
  end
end
