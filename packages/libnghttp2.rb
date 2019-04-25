require 'package'

class Libnghttp2 < Package
  description 'library implementing HTTP/2 protocol'
  homepage 'https://nghttp2.org/'
  version '1.38.0'
  source_url 'https://github.com/nghttp2/nghttp2/releases/download/v1.38.0/nghttp2-1.38.0.tar.xz'
  source_sha256 'ef75c761858241c6b4372fa6397aa0481a984b84b7b07c4ec7dc2d7b9eee87f8'

  binary_url ({
  })
  binary_sha256 ({
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
