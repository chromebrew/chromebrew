require 'package'

class Vdev < Package
  description 'A device-file manager for *nix'
  homepage 'https://github.com/jcnelson/vdev'
  version 'ceb7a6'
  source_url 'https://github.com/jcnelson/vdev/archive/ceb7a6c4f44dec542dc1c3c3d5abd27dec7f3e0e.tar.gz'
  source_sha256 'dbf561890aa70a8619506d166803a72d0c2a5b7590226feef784ec623bcb4739'

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
