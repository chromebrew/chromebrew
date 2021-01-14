require 'package'

class Busybox < Package
  description 'BusyBox is a software suite that provides several Unix utilities in a single executable file'
  homepage 'https://busybox.net'
  compatibility 'all'
  version '1.33.0'
  source_url 'https://www.busybox.net/downloads/busybox-1.33.0.tar.bz2'
  source_sha256 'd568681c91a85edc6710770cebc1e80e042ad74d305b5c2e6d57a5f3de3b8fbd'

  def self.patch
      # There's probably a way to use ruby to download this file. If anyone who knows ruby wants to change it, please do so.
      # When the package is merged, change the curl command to:
      #system "curl -#L https://raw.github.com/skycocker/chromebrew/master/misc/busybox-config -o ./.config"
      system "curl -#L https://raw.github.com/saltedcoffii/chromebrew/patch-16/misc/busybox-config -o ./.config" 
      system "make", "oldconfig"
  end

  def self.build
      system "make"
  end
    
  def self.install
    system "install -Dm 755 0_lib/busybox #{CREW_DEST_PREFIX}/bin/busybox"
    system "install -Dm 755 0_lib/libbusybox.so.1.33.0 #{CREW_DEST_LIB_PREFIX}/libbusybox.so.1.33.0"
  end

  def self.check
    system "make", "check"
  end
end