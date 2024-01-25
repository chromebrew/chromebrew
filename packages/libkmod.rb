require 'package'

class Libkmod < Package
  description 'Linux kernel module handling library'
  homepage 'https://kernel.org'
  version '29'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '40fe9af2580dbc280c5c8b44f9dccbd4869cdb439eeee510bc26468f2652fa32',
     armv7l: '40fe9af2580dbc280c5c8b44f9dccbd4869cdb439eeee510bc26468f2652fa32',
       i686: 'e3cbd134f96e7e25cba0eb1e721ecaa2372c218ff1deb5d5da9303691f6fc42b',
     x86_64: 'a69c727d00f82f0e50dc12f2030e613a50f21095d070c80d59437f9eab02e372'
  })

  depends_on 'py3_cython'
  depends_on 'xzutils'

  def self.build
    system './autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS} \
    --disable-maintainer-mode \
    --enable-python \
    --with-openssl \
    --with-xz \
    --with-zlib \
    --with-zstd"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/sbin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/bin/lsmod"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/depmod"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/insmod"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/modinfo"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/modprobe"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/kmod", "#{CREW_DEST_PREFIX}/sbin/rmmod"
  end
end
