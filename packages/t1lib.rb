# Adapted from Arch Linux t1lib PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/t1lib/trunk/PKGBUILD

require 'package'

class T1lib < Package
  description 'Library for generating character- and string-glyphs from Adobe Type 1 fonts'
  homepage 'https://www.ibiblio.org/pub/Linux/libs/graphics/!INDEX.html'
  version '5.1.2'
  license 'GPL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://www.ibiblio.org/pub/Linux/libs/graphics/t1lib-#{version}.tar.gz"
  source_sha256 '821328b5054f7890a0d0cd2f52825270705df3641dbd476d58d17e56ed957b59'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/t1lib/5.1.2_armv7l/t1lib-5.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/t1lib/5.1.2_armv7l/t1lib-5.1.2-chromeos-armv7l.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/t1lib/5.1.2_x86_64/t1lib-5.1.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2f4799df219c60ac0ece07da29347d070b16671e3d003e988d586baf18018ecb',
     armv7l: '2f4799df219c60ac0ece07da29347d070b16671e3d003e988d586baf18018ecb',
     x86_64: '5d5639a6ef9375aedda35def52d0d178d87cd1d725dd36a67544e8c5e8fc11d2'
  })

  depends_on 'hashpipe' => :build
  depends_on 'libice'
  depends_on 'libsm'
  depends_on 'libx11'
  depends_on 'libxaw'
  depends_on 'libxext'
  depends_on 'libxmu'
  depends_on 'libxpm'
  depends_on 'libxt'

  def self.patch
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/packages/t1lib/trunk/lib-cleanup.diff | \
      hashpipe sha256 5b161f4e0f4ad297ad8eea70ea99620f5db6f7e487bbd63a819b6a9958540961 | patch -Np1 --binary'
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/packages/t1lib/trunk/format-security.diff | \
      hashpipe sha256 89b0aa7ca57fd8e9753336033c1d3e3e58c6c79e943144430e8af9a4626fdd25 | patch -Np1 --binary'
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/packages/t1lib/trunk/CVE-2011-0764.diff | \
      hashpipe sha256 a763650bdcffd33a61cd2cecef766b8d6baa9999561463ae9dfdc20d55caef04 | patch -Np1 --binary'
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/packages/t1lib/trunk/CVE-2011-1552_1553_1554.patch | \
      hashpipe sha256 4bc34e092fdec37e06b38b5b7a3b02194732dbe6a39edbd174b36c2db1f113ac | patch -Np1 --binary'
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/packages/t1lib/trunk/CVE-2010-2642.patch | \
      hashpipe sha256 dcd9064f368e0fc1f3ede0a45e61b364f6b5d3607dccae78ac07e74ca315a27d | patch -Np1 --binary'
  end

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make without_doc'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
