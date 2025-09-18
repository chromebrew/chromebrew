require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  version '2.76'
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ff3701374ff576b67ceab24e9e3b853cc11743960c9bb097b339c8a09623ab5',
     armv7l: '9ff3701374ff576b67ceab24e9e3b853cc11743960c9bb097b339c8a09623ab5',
       i686: 'cbeac1a46c24e5b371df05390528a81c9292dff0febf210940b96552b9076541',
     x86_64: '6dbc5549fd75d3b89e0036ad1b455f0613330662f5db871a47257b887990a5d1'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build
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
    if ARCH == 'x86_64'
      # use system libdir
      system "sed -i 's,^lib_prefix=\$(exec_prefix),lib_prefix=#{CREW_LIB_PREFIX},g' Make.Rules"
    end
    # http://git.yoctoproject.org/cgit.cgi/poky/plain/meta/recipes-support/libcap/files/0001-ensure-the-XATTR_NAME_CAPS-is-defined-when-it-is-use.patch
    system 'sed -i "s,^\#ifdef VFS_CAP_U32,\#if defined (VFS_CAP_U32) \&\& defined (XATTR_NAME_CAPS),g" libcap/cap_file.c'
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', 'RAISE_SETFCAP=no', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    # Tests do not work in a Docker container.
    return if CREW_IN_CONTAINER

    system 'make', 'test'
  end
end
