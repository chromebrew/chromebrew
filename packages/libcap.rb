require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap/'
  @_ver = '2.64'
  version @_ver
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.64_armv7l/libcap-2.64-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.64_armv7l/libcap-2.64-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.64_i686/libcap-2.64-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.64_x86_64/libcap-2.64-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '03701822e8ae9cfee9ea023b377499797b037372c204f27c755bf68a01dddd4c',
     armv7l: '03701822e8ae9cfee9ea023b377499797b037372c204f27c755bf68a01dddd4c',
       i686: '4032d0a74b1b6a23da3d97643f14c830d7499c7b3d8677715bb369e77054a655',
     x86_64: 'cc6593f845dfc3adc63cfd5dadaf23117c646ae5d37442961380fe0f82295fe3'
  })

  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'linux_pam'

  def self.patch
    # add includes option to make it work with gperf-3.1
    system 'sed -e "/gperf --/s/gperf --/gperf --includes --/" -e "/gperf --/s/cap_lookup_name(/cap_dummy(/" -i libcap/Makefile'
    # change the path to ld
    system "sed -i 's,/usr/bin/ld,#{CREW_PREFIX}/bin/ld,g' Make.Rules"
    # change prefix
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},g' Make.Rules"
    # set exec_prefix
    system "sed -i 's,^exec_prefix=,exec_prefix=\$(prefix),g' Make.Rules"
    # use system libdir
    case ARCH
    when 'armv7l', 'aarch64'
      system "sed -i 's,^lib_prefix=\$(exec_prefix),lib_prefix=#{CREW_LIB_PREFIX},g' Make.Rules"
    end
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
  end

  def self.build
    system "#{CREW_ENV_OPTIONS} make"
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Tests do not work in a Docker container.
    return if File.exist?('/.dockerenv')

    system 'make', 'test'
  end
end
