require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap/'
  @_ver = '2.63'
  version @_ver
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.63_armv7l/libcap-2.63-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.63_armv7l/libcap-2.63-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.63_i686/libcap-2.63-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcap/2.63_x86_64/libcap-2.63-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b090422c28aa929a2a585c73739eda6c8c953379ecb0b90f1f596ad5e37706de',
     armv7l: 'b090422c28aa929a2a585c73739eda6c8c953379ecb0b90f1f596ad5e37706de',
       i686: '235e7deaec2896dd3db2af3b851699c1fd4dd680b6e2e02d91b895d54ca6d01b',
     x86_64: '2e306e64bf4f170ad232ab0a64de65a5c4dbbb877ce6f5d7e7ebaa57c39acdde'
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
    # Tests do not work in a Docker container.
    return if File.exist?('/.dockerenv')

    system 'make', 'test'
  end
end
