require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap/'
  @_ver = '2.62'
  version @_ver
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.62_armv7l/libcap-2.62-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.62_armv7l/libcap-2.62-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.62_i686/libcap-2.62-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.62_x86_64/libcap-2.62-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ad1ba9eeb6311aa50cae4933861e6ef3c6660114f8f59fae8b38ec33cf52f4ba',
     armv7l: 'ad1ba9eeb6311aa50cae4933861e6ef3c6660114f8f59fae8b38ec33cf52f4ba',
       i686: 'fde7113445a251b6109911cbd5de39300ec2469091cdaea6bc6a57e726e0ef86',
     x86_64: '3964a327f72a3323e1a192d5fbe4020f29e83ede75347e0d65582ace36f4f66b'
  })

  depends_on 'gperf' => :build
  depends_on 'linux_pam'

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
    system "sed -i 's,^lib_prefix=\$(exec_prefix),lib_prefix=#{CREW_LIB_PREFIX},g' Make.Rules"
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
    system "#{CREW_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    @container_check = system 'grep :/docker /proc/self/cgroup &> /dev/null'
    # Tests do not work in container.
    return unless @container_check

    system 'make', 'test'
  end
end
