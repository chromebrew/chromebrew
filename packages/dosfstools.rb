require 'package'

class Dosfstools < Package
  description 'dosfstools consists of the programs mkfs.fat, fsck.fat and fatlabel to create, check and label file systems of the FAT family.'
  homepage 'https://github.com/dosfstools/dosfstools'
  version '4.1'
  compatibility 'all'
  source_url 'https://github.com/dosfstools/dosfstools/releases/download/v4.1/dosfstools-4.1.tar.xz'
  source_sha256 'e6b2aca70ccc3fe3687365009dd94a2e18e82b688ed4e260e04b7412471cc173'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dosfstools-4.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dosfstools-4.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dosfstools-4.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dosfstools-4.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a2fa41c25a7aee9ae85cd1b7759d3de0f89c6e3863ab26b7959d0b7f7c4acae6',
     armv7l: 'a2fa41c25a7aee9ae85cd1b7759d3de0f89c6e3863ab26b7959d0b7f7c4acae6',
       i686: '5e71d1e528360ce349a3a609ffad1d5723a91fc2687a76b8fe5f2a8c8437665c',
     x86_64: '430a5579234dd68276ecb94cd24c0e5b894b26f04e76b09d2268aeaef7467046',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-compat-symlinks"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
