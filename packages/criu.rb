# Adapted from Arch Linux criu PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/criu/trunk/PKGBUILD

require 'package'

class Criu < Package
  description 'Utilities to checkpoint and restore processes in userspace'
  homepage 'https://criu.org'
  version '3.17.1'
  license 'GPL2'
  compatibility 'x86_64'
  source_url 'https://github.com/checkpoint-restore/criu.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    x86_64: '1f2d925e397b49970d38fa034cb71d9af0f8e159b9b34c0afd0d8f93e6fadf5c'
  })

  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'libbsd' # R
  depends_on 'libcap' => :build
  depends_on 'libnet' # R
  depends_on 'libnl3' # R
  depends_on 'nftables' # R
  depends_on 'protobuf' => :build
  depends_on 'protobuf_c' # R
  depends_on 'xmlto' => :build

  def self.patch
    # Fix hard coded symlink path
    FileUtils.ln_sf "#{CREW_PREFIX}/include/google/protobuf/descriptor.proto", 'images/google/protobuf/descriptor.proto'
    system "sed -i 's,/etc,#{CREW_PREFIX}/etc,g' criu/Makefile"
    # Get this error on armv7l:
    # lto-wrapper: warning: using serial compilation of 15 LTRANS jobs
    # lto-wrapper: note: see the ‘-flto’ option documentation for more information
    # mold: error: undefined symbol: test_and_set_bit
    # >>> referenced by <artificial>
    # >>>               /usr/local/tmp/cc7xJrLk.ltrans4.ltrans.o:(set_fds_event)
    # collect2: error: ld returned 1 exit status
    # make[1]: *** [criu/Makefile:88: criu/criu] Error 1
  end

  def self.build
    system 'unset ARCH ; LD=ld.bfd make'
  end

  def self.install
    system "unset ARCH ; LD=ld.bfd make DESTDIR=#{CREW_DEST_DIR} PREFIX=#{CREW_PREFIX} SBINDIR=#{CREW_PREFIX}/bin LIBDIR=#{CREW_LIB_PREFIX} LIBEXECDIR=#{CREW_LIB_PREFIX} install"
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/include/compel/common/asm"
    FileUtils.rm_rf "#{CREW_DEST_DIR}/var"
  end
end
