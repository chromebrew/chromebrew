require 'package'

class Ilmbase < Package
  description 'Supporting libraries for OpenEXR'
  homepage 'http://www.openexr.com/'
  version '2.3.0'
  compatibility 'all'
  source_url 'https://github.com/openexr/openexr/releases/download/v2.3.0/ilmbase-2.3.0.tar.gz'
  source_sha256 '456978d1a978a5f823c7c675f3f36b0ae14dba36638aeaa3c4b0e784f12a3862'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/ilmbase-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/ilmbase-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/ilmbase-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/ilmbase-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2409254e52175a62f82fba8cc1362f9cbb03ab473e0a23be82616346ac3fb63c',
     armv7l: '2409254e52175a62f82fba8cc1362f9cbb03ab473e0a23be82616346ac3fb63c',
       i686: '4dcff79fad721cd25e2a4ce9fbad88627b3aab051f638cbbfe3444069b5e538b',
     x86_64: '76a019fd719ce2bc922396ca3ff5297f45fdbedf29a509fdcc853e36a61b17f5',
  })

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
