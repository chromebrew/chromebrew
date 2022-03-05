require 'package'

class Udisks2 < Package
  description 'The UDisks project provides a daemon, tools and libraries to access and manipulate disks, storage devices and technologies.'
  homepage 'https://github.com/storaged-project/udisks'
  version '2.9.4'    
  license 'GPL-2.0+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/storaged-project/udisks/releases/download/udisks-2.9.4/udisks-2.9.4.tar.bz2'
  source_sha256 'b6b60ebab0d5e09624120c5d158882e87d8c2473db60783b63deeba74cb18d1c'

  depends_on 'libatasmart' => :build
  depends_on 'libblockdev' => :build
  depends_on 'libgudev' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} --with-gtk-doc=no --disable-man"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
