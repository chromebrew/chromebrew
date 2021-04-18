require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  @_ver = '2.49'
  version @_ver
  compatibility 'all'
  source_url "https://mirrors.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-#{@_ver}.tar.xz"
  source_sha256 'e98bc4d93645082ec787730b0fd1a712b38882465c505777de17c338831ee181'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libcap-2.49-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libcap-2.49-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libcap-2.49-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libcap-2.49-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a70c7ce2ce27a15a294ce7229c10a1c2227c2705a8b0e0be88cf8bb5eed73e77',
     armv7l: 'a70c7ce2ce27a15a294ce7229c10a1c2227c2705a8b0e0be88cf8bb5eed73e77',
       i686: 'ff41b92eeeb4c068086e67322b6a3fa9609b883a84c29f5a10c51dc3d38aa09c',
     x86_64: 'bc72fba8169275a4e7a78ee90eea47a20b42fa0544eb321d2c1c1549640982b6'
  })

  depends_on 'gperf' => :build
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
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' make"
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/sbin/capsh"
  end
end
