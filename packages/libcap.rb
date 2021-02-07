require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  @_ver = '2.48'
  version @_ver
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-#{@_ver}.tar.xz"
  source_sha256 '4de9590ee09a87c282d558737ffb5b6175ccbfd26d580add10df44d0f047f6c2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.48-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.48-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.48-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.48-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '106370bd011b5275a149acd944f2a2f06ed016c9cf177460d11eec27739c198f',
     armv7l: '106370bd011b5275a149acd944f2a2f06ed016c9cf177460d11eec27739c198f',
       i686: 'efff029eb82405b068585b990adecdd8d4f16cf44fe3d09da6881c9904570b36',
     x86_64: '409ae3d9206df71754817d0c49317e6533936e071b26c053141115fdd8dfb56c'
  })

  depends_on 'gperf' => :build
  depends_on 'perl' => :build
  depends_on 'linux_pam'
  depends_on 'patchelf' => :build

  def self.build
    # add includes option to make it work with gperf-3.1
    system 'sed -e "/gperf --/s/gperf --/gperf --includes --/" -e "/gperf --/s/cap_lookup_name(/cap_dummy(/" -i libcap/Makefile'

    # change the path to ld
    system "sed -i 's,/usr/bin/ld,#{CREW_PREFIX}/bin/ld,g' Make.Rules"
    # change prefix
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},' Make.Rules"
    # set exec_prefix
    system "sed -i 's,^exec_prefix=,exec_prefix=\$(prefix),' Make.Rules"
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' make"
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/sbin/capsh"
  end
end
