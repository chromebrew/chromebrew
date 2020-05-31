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
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-2.9.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-2.9.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-2.9.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fuse-2.9.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '03a58f54469a301789facbcceebe9883b4bba39d985f385e9635a1f8fb03a64c',
     armv7l: '03a58f54469a301789facbcceebe9883b4bba39d985f385e9635a1f8fb03a64c',
       i686: 'd693b74e82fac0794d0c0d4111cb8ca1f0e8fdd0d8eaf1a7ad5fbf9900eb35ea',
     x86_64: 'd7f7447ecda964a07154cb717cc78e876fe4199b34f03085b45da268b7a6dcca',
  })

  def self.build
    ENV['TMPDIR'] = "#{CREW_PREFIX}/tmp"
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
