require 'package'

class Libkmod < Package
  description 'Linux kernel module handling library'
  homepage 'https://kernel.org'
  version = '29'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git"
  git_hashtag "v#{version}"

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libkmod/28_armv7l/libkmod-28-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libkmod/28_armv7l/libkmod-28-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libkmod/28_i686/libkmod-28-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libkmod/28_x86_64/libkmod-28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '57c5726cd378bf3e1458cdfebead52b9279557af8229550d5f91f0a3e04d4f10',
      armv7l: '57c5726cd378bf3e1458cdfebead52b9279557af8229550d5f91f0a3e04d4f10',
        i686: '95c805d62289d8751682d4bb1c8046deeae68958e0f06f6863e30eb74e941864',
      x86_64: '258578c242a793bfda78e9dc98a9e029a8788e9971a809d0c6e42c2abe10b317',
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
