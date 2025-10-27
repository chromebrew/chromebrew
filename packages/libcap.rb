require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  version '2.77'
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53a9ed1dd6adba482e5fa7fb282166e9fc649602c957bc1c46b5d7250d7b7749',
     armv7l: '53a9ed1dd6adba482e5fa7fb282166e9fc649602c957bc1c46b5d7250d7b7749',
       i686: 'fd451051eca326a62edfe7c7a04ab8a6a932d3b27767d0277b2668b60e57eacc',
     x86_64: '9d025a75fe53b685fcdff3aa2030b110367f26f2954bd84628f8f67306d11ea2'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build
  depends_on 'gperf' => :build
  depends_on 'linux_pam' => :build

  def self.patch
    # add includes option to make it work with gperf-3.1
    system 'sed -e "/gperf --/s/gperf --/gperf --includes --/" -e "/gperf --/s/cap_lookup_name(/cap_dummy(/" -i libcap/Makefile'
    # change the path to ld
    system "sed -i 's,/usr/bin/ld,#{CREW_PREFIX}/bin/ld,g' Make.Rules"
    # change prefix
    system "sed -i 's,prefix=/usr,prefix=#{CREW_PREFIX},g' Make.Rules"
    # set exec_prefix
    system "sed -i 's,^exec_prefix=,exec_prefix=\$(prefix),g' Make.Rules"
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
