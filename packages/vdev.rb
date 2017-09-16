require 'package'

class Vdev < Package
  description 'A device-file manager for *nix'
  homepage 'https://github.com/jcnelson/vdev'
  version '1.0.0'
  source_url 'https://github.com/flyingP0tat0/vdev/archive/1.0.0.tar.gz'
  source_sha256 '971b31486e8abe76d81891832b3c5c31441f5585a5731afdeedc8b2bc57271f7'

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
