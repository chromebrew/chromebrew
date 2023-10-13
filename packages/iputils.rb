require 'package'

class Iputils < Package
  description 'A set of small useful utilities for Linux networking.'
  homepage 'https://github.com/iputils/iputils'
  version '20211215'
  license 'GPL-2, BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/iputils/iputils/archive/refs/tags/20211215.tar.gz'
  source_sha256 'b6f67fc705490673ff4471d006221b4a2f1b1180b929d9fefd771352621ccedf'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iputils/20211215_armv7l/iputils-20211215-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iputils/20211215_armv7l/iputils-20211215-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/iputils/20211215_x86_64/iputils-20211215-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '97f4127a95b6eceb0e4329ccdb156fc929062c30cbc291e53133f047d8b7db0c',
     armv7l: '97f4127a95b6eceb0e4329ccdb156fc929062c30cbc291e53133f047d8b7db0c',
     x86_64: 'd0f452650e1f52ec27e098e22e7903ecf6b6e92824f7ff7ed17eb16a469aa232'
  })

  depends_on 'libcap'

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
