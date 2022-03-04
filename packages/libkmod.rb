require 'package'

class Libkmod < Package
  description 'Linux kernel module handling library'
  homepage 'https://kernel.org'
  version = '29'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git"
  git_hashtag "v#{version}"

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
