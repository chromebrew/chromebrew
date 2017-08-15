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

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fuse-2.8.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fuse-2.8.6-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/fuse-2.8.6-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/fuse-2.8.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9c72f6cfa101f59fc44052f7ccb3b49bf89ab69df47a965ba382b058d96db1ad',
     armv7l: '9c72f6cfa101f59fc44052f7ccb3b49bf89ab69df47a965ba382b058d96db1ad',
       i686: 'c2d3b90b071d6b9124dbf9eb464964ed1920d42bdd6dc8ed3734d2b5d6fedcf4',
     x86_64: 'c7a29efb8445804c05b642e102db77e3b1660e74b89fc200572a03a8a7aa5bd1',
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
