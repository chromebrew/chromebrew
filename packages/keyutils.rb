require 'package'

class Keyutils < Package
  description 'Keyutils is a set of utilities for managing the key retention facility in the kernel, which can be used by filesystems, block devices and more to gain and retain the authorization and encryption keys required to perform secure operations.'
  homepage 'https://people.redhat.com/~dhowells/keyutils/'
  version '1.6.1'    
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://people.redhat.com/~dhowells/keyutils/keyutils-1.6.1.tar.bz2'
  source_sha256 'c8b15722ae51d95b9ad76cc6d49a4c2cc19b0c60f72f61fb9bf43eea7cbd64ce'
  
  depends_on 'hashpipe' => :build
  
  def self.patch
    system "curl -L 'https://gist.githubusercontent.com/Zopolis4/1a0f93d982c87587bc0bb4e4cb0595b8/raw/5e2d7d523740d92c45af1d98a730a7323038db36/keyutils_chromebrew.patch' | hashpipe sha256 861cfd398475cafb50c7009d0d496ca86917d0d13f79406ecbd0c8e3ab2128f1 | patch -u Makefile"
  end

  def self.build
    system "make"
  end

  def self.install
    system "make install LIBDIR=#{CREW_LIB_PREFIX} DESTDIR=#{CREW_DEST_DIR}"
  end
end