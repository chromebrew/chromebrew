require 'package'

class Fuse < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  # The version of libfuse need to be matched with ChromeOS /usr/lib/libfuse.so since we must use
  # /sbin/mount.fuse which is not possible to be overwritten.  If we use different version of
  # libfuse, it may cause errors.  Chrome OS 59 and 60 use libfuse 2.8.6.
  version '2.8.6'
  source_url 'https://github.com/libfuse/libfuse/releases/download/fuse_2_9_4/fuse-2.8.6.tar.gz'
  source_sha256 '1ec1913e38f09b2a9ec1579e1800805b5e2c747d1dce515e316dbb665ca139d6'

  def self.build
    # Disable util since we must use pre-installed /sbin/mount.fuse
    system "./configure", "--libdir=#{CREW_LIB_PREFIX}", "--enable-shared", "--disable-static", "--with-pic", "--disable-util"
    # A workaround to "'CLONE_NEWNS' undeclared" error.  See below for details.
    # https://github.com/libfuse/libfuse/commit/ae43094c13ecf49e0b738bbda633cf193c7b3670
    system "sed -i util/fusermount.c -e '1i#define _GNU_SOURCE'"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
