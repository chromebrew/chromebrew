require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  version '2.25-1'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.xz'
  source_sha256 '693c8ac51e983ee678205571ef272439d83afe62dd8e424ea14ad9790bc35162'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.25-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.25-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.25-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcap-2.25-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e16e2cff870a30f50b4b17284325b672c5f204eeec9c28753d6dfd4998c1593c',
     armv7l: 'e16e2cff870a30f50b4b17284325b672c5f204eeec9c28753d6dfd4998c1593c',
       i686: 'da6a3a37bb2c9fa6cfdafbec225b7038d37c77b87c8a8b0e3c9573358ce95efd',
     x86_64: '4aec1e1f208538ec02df02808e9a40df4628a0bfb019367e3f7059fa1debe1bc',
  })

  depends_on 'gperf' => :build
  depends_on 'perl' => :build

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
    system 'make'
  end

  def self.install
    system "make", "RAISE_SETFCAP=no", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
