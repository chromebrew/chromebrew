require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap/'
  @_ver = '2.62'
  version @_ver
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/libs/libcap/libcap.git"
  git_hashtag 'libcap-' + @_ver

  depends_on 'gperf' => :build
  depends_on 'linux_pam'
  depends_on 'patchelf' => :build

  def self.build
    # add includes option to make it work with gperf-3.1
    system 'sed -e "/gperf --/s/gperf --/gperf --includes --/" -e "/gperf --/s/cap_lookup_name(/cap_dummy(/" -i libcap/Makefile'
    # change the path to ld
    system "sed -i 's,/usr/bin/ld,#{CREW_PREFIX}/bin/ld,g' Make.Rules"
    # change prefix
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},g' Make.Rules"
    # set exec_prefix
    system "sed -i 's,^exec_prefix=,exec_prefix=\$(prefix),g' Make.Rules"
    # use system libdir
    system "sed -i 's,^lib_prefix=$(exec_prefix),lib_prefix=#{CREW_LIB_PREFIX},g' Make.Rules"
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
    system "#{CREW_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    #system "patchelf --set-rpath #{CREW_LIB_PREFIX} #{CREW_DEST_PREFIX}/sbin/capsh"
  end

  def self.check
    system 'make', 'test'
  end
end
