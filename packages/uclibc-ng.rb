require 'package'

class Uclibc-ng < Package
  description 'uClibc-ng is a small C library for developing embedded Linux systems. \nIt is much smaller than the GNU C Library,\n but nearly all applications supported by glibc also work perfectly with uClibc-ng'
  homepage 'https://uclibc-ng.org/'
  version '1.0.30'
  source_url 'https://downloads.uclibc-ng.org/releases/1.0.30/uClibc-ng-1.0.30.tar.xz'
  source_sha256 '992bd9a2889ea385902b87e3d3d30603741eb16728288fbf537ff2027f770496'

  depends_on 'glibc_headers' => :build
  
  def self.build
    system "make", "menuconfig"
    system "./configure"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
