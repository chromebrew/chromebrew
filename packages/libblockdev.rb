require 'package'

class Libblockdev < Package
  description 'A library for manipulating block devices.'
  homepage 'https://github.com/storaged-project/libblockdev'
  version '2.26'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/storaged-project/libblockdev/releases/download/#{version}-1/libblockdev-#{version}.tar.gz"
  source_sha256 'c4c0e10b35ac632bda8ce6d200b5601184984dec387fe59185921eb42432e069'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libblockdev/2.26_armv7l/libblockdev-2.26-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libblockdev/2.26_armv7l/libblockdev-2.26-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libblockdev/2.26_x86_64/libblockdev-2.26-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '20413e951e4b4d593ca0ca42789932a1ea624f53a33a022c190a318ba868d718',
     armv7l: '20413e951e4b4d593ca0ca42789932a1ea624f53a33a022c190a318ba868d718',
     x86_64: 'f4ebe749826e5b659043b618d759891d5a6a1e9f2540e855ae2927b2dd9711a5'
  })

  depends_on 'cryptsetup' => :build
  depends_on 'eudev' => :build
  depends_on 'glib' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gpgme' => :build
  depends_on 'libbytesize' => :build
  depends_on 'libdmraid' => :build
  depends_on 'libkmod' => :build
  depends_on 'libnvme' => :build
  depends_on 'ndctl' => :build
  depends_on 'nss' => :build
  depends_on 'parted' => :build
  depends_on 'polkit' => :build
  depends_on 'volume_key' => :build

  def self.build
    system 'filefix'
    system "./configure #{CREW_OPTIONS} --with-gtk-doc=no"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
