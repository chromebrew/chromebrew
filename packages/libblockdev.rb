require 'package'

class Libblockdev < Package
  description 'A library for manipulating block devices.'
  homepage 'https://github.com/storaged-project/libblockdev'
  version '2.26-1'    
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/storaged-project/libblockdev/releases/download/2.26-1/libblockdev-2.26.tar.gz'
  source_sha256 'c4c0e10b35ac632bda8ce6d200b5601184984dec387fe59185921eb42432e069'

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
    
    ## crew install buildessential lvm2 cryptsetup libbytesize libdmraid volume_key
#No package 'glib-2.0' found (solvable by glib)
#No package 'gobject-2.0' found (solvable by glib but it still checks for gobject_introspection)
#No package 'gio-2.0' found
#No package 'libudev' found
#No package 'libkmod' found (solvable by libkmod)
#No package 'libcryptsetup' found
#No package 'nss' found
#libvolume_key.h not available
#No package 'libparted' found (solvable by parted)
#No package 'mount' found
#No package 'blkid' found (solvable by util_linux)
#No package 'uuid' found
#No package 'libndctl' found

  def self.build
   #system "ln -s /bin/sed /usr/local/bin/sed"
    system "./configure"
    system "make"
  end

  def self.install
    system "make install"
  end
end