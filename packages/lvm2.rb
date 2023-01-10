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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_armv7l/lvm2-2.03.18-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_armv7l/lvm2-2.03.18-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_i686/lvm2-2.03.18-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lvm2/2.03.18_x86_64/lvm2-2.03.18-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '267db66e0d088def3d3644b48fa5621eb05ed4641554de044186c093a3fbfecb',
     armv7l: '267db66e0d088def3d3644b48fa5621eb05ed4641554de044186c093a3fbfecb',
       i686: '0d3c7c5e3322a8244e970dfa09e21ab50f54d34a1219725f0b7fad0658378ca4',
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
