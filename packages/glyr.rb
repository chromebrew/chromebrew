require 'package'

class Glyr < Package
  description 'Glyr is a music related metadata search engine'
  homepage 'https://github.com/sahib/glyr'
  version '1.0.10'
  compatibility 'all'
  source_url 'https://github.com/sahib/glyr/archive/1.0.10.tar.gz'
  source_sha256 '77e8da60221c8d27612e4a36482069f26f8ed74a1b2768ebc373c8144ca806e8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glyr-1.0.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glyr-1.0.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glyr-1.0.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glyr-1.0.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9b5746c110bc3e87a3bab7a56060e95e1fe066371b78c43afdd0fcc9fcb11d2',
     armv7l: 'e9b5746c110bc3e87a3bab7a56060e95e1fe066371b78c43afdd0fcc9fcb11d2',
       i686: 'abbd00b032fcf540c2b6d46562242272d7be300ba88baa991d8ad9db8463d8e2',
     x86_64: 'c9ade91fe3da5da7cd53d53ff9e17a072fc60dd540f2e812ebfccdfe041aed50',
  })

  depends_on 'curl'
  depends_on 'glib'
  depends_on 'sqlite'

  def self.build
    if ARCH == 'x86_64'
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DLIB_SUFFIX=64"
    else
      system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}"
    end
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
