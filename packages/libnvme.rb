require 'package'

class Libnvme < Package
  description 'C Library for NVM Express on Linux'
  homepage 'https://github.com/linux-nvme/libnvme'
  version 'v1.0-rc4'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/linux-nvme/libnvme/archive/refs/tags/v1.0-rc4.tar.gz'
  source_sha256 '82dc150c09e5e211d5200a37fabbbe25c69f5b0f22582956e51587a5a54463b5'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnvme/v1.0-rc4_armv7l/libnvme-v1.0-rc4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnvme/v1.0-rc4_armv7l/libnvme-v1.0-rc4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnvme/v1.0-rc4_i686/libnvme-v1.0-rc4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libnvme/v1.0-rc4_x86_64/libnvme-v1.0-rc4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '96065314bcf7521308042f931dd12c9f12e50181bbc2b6badbf9afa55affef7b',
     armv7l: '96065314bcf7521308042f931dd12c9f12e50181bbc2b6badbf9afa55affef7b',
       i686: '4851ac87efb9002edcca1ef588e3a47a68f6d71d2922caab750aa70dc9b5cc88',
     x86_64: '29c8f05ab437e44302ea683763a4fec9d67f2bef1d1bcd92db473b5df01d851d'
  })

  depends_on 'jsonc' => :build
  depends_on 'ninja' => :build
  depends_on 'openssl' => :build
  depends_on 'swig' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure --no-pager builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
