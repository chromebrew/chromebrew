require 'package'

class Ecl < Package
  description 'Embeddable Common-Lisp is an interpreter of the Common-Lisp language.'
  homepage 'https://common-lisp.net/project/ecl/index.html'
  version '20.4.24'
  compatibility 'all'
  source_url 'https://gitlab.com/embeddable-common-lisp/ecl/-/archive/20.4.24/ecl-20.4.24.tar.gz'
  source_sha256 '670838edf258a936b522fdb620da336de7e575aa0d27e34841727252726d0f07'

  binary_url ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })
  binary_sha256 ({
    aarch64: '',
     armv7l: '',
       i686: '',
     x86_64: '',
  })

  def self.build
    system './configure', "--prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
