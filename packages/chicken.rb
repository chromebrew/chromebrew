require 'package'

class Chicken < Package
  description 'CHICKEN is a practical and portable scheme system.'
  homepage 'https://code.call-cc.org/'
  version '5.4.0'
  license 'BSD'
  compatibility 'all'
  source_url "https://code.call-cc.org/releases/#{version}/chicken-#{version}.tar.gz"
  source_sha256 '3c5d4aa61c1167bf6d9bf9eaf891da7630ba9f5f3c15bf09515a7039bfcdec5f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9821dfba5cd2e2be8653792fe29a3524e2851a99320702b304fe946963012fe',
     armv7l: 'f9821dfba5cd2e2be8653792fe29a3524e2851a99320702b304fe946963012fe',
       i686: 'f5b00b3ac5b6e06fbc17ba765cc1ad44de159178117ecf361fa1741413acc5a8',
     x86_64: '82e81bf7b319bd2b879407968928fa3adac20d0ee8ea74e3dd62058aafdc8b99'
  })

  depends_on 'filecmd' => :build

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
