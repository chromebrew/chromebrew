require 'package'

class Lvm2 < Package
  description 'LVM2 refers to the userspace toolset that provide logical volume management facilities on linux.'
  homepage 'https://sourceware.org/lvm2'
  version '2.03.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/git/lvm2.git'
  git_hashtag "v#{version.gsub('.', '_')}"

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.15_i686/lvm2-2.03.15-chromeos-i686.tar.zst',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_armv7l/lvm2-2.03.18-chromeos-armv7l.tar.zst',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_armv7l/lvm2-2.03.18-chromeos-armv7l.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_x86_64/lvm2-2.03.18-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'fcc82c8f6189cd3e7050db3b6a2d4b2e18f920888e438c94bbe1620331aa2932',
 aarch64: '267db66e0d088def3d3644b48fa5621eb05ed4641554de044186c093a3fbfecb',
  armv7l: '267db66e0d088def3d3644b48fa5621eb05ed4641554de044186c093a3fbfecb',
  x86_64: '8c7d270a64308d1cb541392abbc23174a09231cb99e1ac3bd5eff5e111d02542'
  })

  depends_on 'glibc' # R
  depends_on 'libaio' # R
  depends_on 'readline' # R
  depends_on 'util_linux' # R

  no_env_options

  def self.build
    system "./configure #{CREW_OPTIONS} \
      --disable-selinux \
      --enable-cmdlib \
      --enable-dmeventd \
      --enable-pkgconfig \
      --with-symvers=no \
      --with-confdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
