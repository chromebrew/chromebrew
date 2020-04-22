require 'package'

class Fuse < Package
  description 'The reference implementation of the Linux FUSE (Filesystem in Userspace) interface.'
  homepage 'https://github.com/libfuse/libfuse'
  # The version of libfuse need to be matched with ChromeOS /usr/lib/libfuse.so since we must use
  # /sbin/mount.fuse which is not possible to be overwritten.  If we use different version of
  # libfuse, it may cause errors.  Chrome OS 81 use libfuse 2.9.8.
  version '2.9.8'
  source_url 'https://github.com/libfuse/libfuse/releases/download/fuse-2.9.8/fuse-2.9.8.tar.gz'
  source_sha256 '5e84f81d8dd527ea74f39b6bc001c874c02bad6871d7a9b0c14efb57430eafe3'

  binary_url ({
  })
  binary_sha256 ({
  })

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
