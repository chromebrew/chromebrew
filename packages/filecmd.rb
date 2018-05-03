require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.33'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.33.tar.gz'
  source_sha256 '1c52c8c3d271cd898d5511c36a68059cda94036111ab293f01f83c3525b737c6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.33-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.33-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.33-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.33-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dd8a3daadd253a86dd3ca0ac056592441eb5dec6fc78d74139afb4b1e97ee668',
     armv7l: 'dd8a3daadd253a86dd3ca0ac056592441eb5dec6fc78d74139afb4b1e97ee668',
       i686: 'ca8c71aa6f90a140bb32b5054500ebbcbc8d029791718beff907afa4db6fda77',
     x86_64: '105812be28707a2c95e1aa82b0ab9f4d7c2e186a8f059660c900c2bdeb2b1bf3',
  })

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--disable-libseccomp"
    system "make"
  end
  def self.check
    system "make", "check"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
