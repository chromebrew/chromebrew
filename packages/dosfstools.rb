require 'package'

class Dosfstools < Package
  description 'dosfstools consists of the programs mkfs.fat, fsck.fat and fatlabel to create, check and label file systems of the FAT family.'
  homepage 'https://github.com/dosfstools/dosfstools'
  compatibility 'all'
  version '4.1'
  source_url 'https://github.com/dosfstools/dosfstools/releases/download/v4.1/dosfstools-4.1.tar.xz'
  source_sha256 'e6b2aca70ccc3fe3687365009dd94a2e18e82b688ed4e260e04b7412471cc173'

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-compat-symlinks"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
