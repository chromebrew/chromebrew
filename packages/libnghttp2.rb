require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version '1.38.0'
  compatibility 'all'
  source_url 'https://github.com/nghttp2/nghttp2/releases/download/v1.38.0/nghttp2-1.38.0.tar.xz'
  source_sha256 'ef75c761858241c6b4372fa6397aa0481a984b84b7b07c4ec7dc2d7b9eee87f8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libnghttp2-1.38.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7375e44ec6c77c7afc760eaa4310d9974e0640cb46053c330b32c0e87bee73f4',
     armv7l: '7375e44ec6c77c7afc760eaa4310d9974e0640cb46053c330b32c0e87bee73f4',
       i686: 'cc5a56e8d3731aab1f8ff2a983e42d147e5a7234206d961e39b69d24d7cc3ffd',
     x86_64: '32428353d0b390ca68f1737ebaead7e5cd5ade1676c7d62896de0553bd58fa39',
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

end
