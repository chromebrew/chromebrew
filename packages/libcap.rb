require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  version '2.25-1'
  source_url 'https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.xz'
  source_sha256 '693c8ac51e983ee678205571ef272439d83afe62dd8e424ea14ad9790bc35162'

  depends_on 'gperf' => :build
  depends_on 'perl' => :build

  def self.build
    # add includes option to make it work with gperf-3.1
    system 'sed -e "/gperf --/s/gperf --/gperf --includes --/" -e "/gperf --/s/cap_lookup_name(/cap_dummy(/" -i libcap/Makefile'

    # change the path to ld
    system 'sed -i "s,/usr/bin/ld,/usr/local/bin/ld,g" Make.Rules'
    # change prefix
    system 'sed -i "s,prefix=/usr,prefix=/usr/local," Make.Rules'
    # set exec_prefix
    system 'sed -i "s,^exec_prefix=,exec_prefix=\$(prefix)," Make.Rules'
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
    system 'make'
  end

  def self.install
    system "make", "RAISE_SETFCAP=no", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
