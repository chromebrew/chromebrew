require 'package'

class Udisks2 < Package
  description 'The UDisks project provides a daemon, tools and libraries to access and manipulate disks, storage devices and technologies.'
  homepage 'https://github.com/storaged-project/udisks'
  version '2.9.4'
  license 'GPL-2.0+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/storaged-project/udisks/releases/download/udisks-2.9.4/udisks-2.9.4.tar.bz2'
  source_sha256 'b6b60ebab0d5e09624120c5d158882e87d8c2473db60783b63deeba74cb18d1c'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/udisks2/2.9.4_armv7l/udisks2-2.9.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/udisks2/2.9.4_armv7l/udisks2-2.9.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/udisks2/2.9.4_x86_64/udisks2-2.9.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '59f26464c9a739f1ef66fa0ead9edb61bbbf166e792898c9ca059d8610b25390',
     armv7l: '59f26464c9a739f1ef66fa0ead9edb61bbbf166e792898c9ca059d8610b25390',
     x86_64: '8d432df4504b775ec135e095d197f25074bf56eeb5c55fb68ccde569e2ecb844'
  })

  depends_on 'libatasmart' => :build
  depends_on 'libblockdev' => :build
  depends_on 'libgudev' => :build
  depends_on 'libkmod' => :build
  depends_on 'polkit' => :build

  def self.build
    system 'filefix'
    system "./configure #{CREW_OPTIONS} --disable-man"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
