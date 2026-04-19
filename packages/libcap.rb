require 'package'

class Libcap < Package
  description 'Libcap implements the user-space interfaces to the POSIX 1003.1e capabilities available in Linux kernels.'
  homepage 'https://directory.fsf.org/wiki/Libcap'
  version '2.78'
  license 'GPL-2 or BSD'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/libs/libcap/libcap.git'
  git_hashtag "libcap-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '90f1464fc16cf779b5b7622a96c86689c839d9e0e55b6f79efc5a595508762e2',
     armv7l: '90f1464fc16cf779b5b7622a96c86689c839d9e0e55b6f79efc5a595508762e2',
       i686: 'faddcf659c5e135b00dc351b35400d2bb427200a6b47b1a27a431d6be38cf9b8',
     x86_64: '38c1b3370f9196a1a17d70736f20f453744310e1a978d63f1f05c199f43b4f99'
  })

  depends_on 'glibc' => :library
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
