require 'package'

class Openexr < Package
  description 'OpenEXR is a high dynamic-range (HDR) image file format developed by Industrial Light & Magic for use in computer imaging applications.'
  homepage 'http://www.openexr.com/'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://github.com/openexr/openexr/releases/download/v2.3.0/openexr-2.3.0.tar.gz'
  source_sha256 'fd6cb3a87f8c1a233be17b94c74799e6241d50fc5efd4df75c7a4b9cf4e25ea6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openexr-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openexr-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openexr-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openexr-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd2c0cda2100a6928c13ee79bd605be4c0457f11b289fe7970ac4fdee18d4653b',
     armv7l: 'd2c0cda2100a6928c13ee79bd605be4c0457f11b289fe7970ac4fdee18d4653b',
       i686: '71fb7e679140b71ada434125e1d3f2d475806fa1bb08d476f196b5999ec04c4c',
     x86_64: '4db94a6aa538bdfb6ab6b41f24d03afab0b81c827d64b2b4bf44d004a8c72d15',
  })

  depends_on 'ilmbase'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
