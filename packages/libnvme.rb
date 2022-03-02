require 'package'

class Libnvme < Package
  description 'C Library for NVM Express on Linux'
  homepage 'https://github.com/linux-nvme/libnvme'
  version 'v1.0-rc4'    
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/linux-nvme/libnvme/archive/refs/tags/v1.0-rc4.tar.gz'
  source_sha256 '82dc150c09e5e211d5200a37fabbbe25c69f5b0f22582956e51587a5a54463b5'

  depends_on 'jsonc' => :build
  depends_on 'ninja' => :build
  depends_on 'openssl' => :build
  depends_on 'swig' => :build
  
  def self.build
    system "meson #{CREW_MESON_OPTIONS}"
    system "meson configure builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "meson -C builddir install DESTDIR=#{CREW_DEST_DIR}"
  end
end
