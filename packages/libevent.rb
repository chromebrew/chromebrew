require 'package'

class Libevent < Package
  description 'The libevent API provides a mechanism to execute a callback function when a specific event occurs on a file descriptor or after a timeout has been reached.'
  homepage 'http://libevent.org/'
  version '2.1.12'
  license 'BSD'
  compatibility 'all'
  source_url "https://github.com/libevent/libevent/releases/download/release-#{version}-stable/libevent-#{version}-stable.tar.gz"
  source_sha256 '92e6de1be9ec176428fd2367677e61ceffc2ee1cb119035037a27d346b0403bb'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'c5617c8ad9ff0c9107a5a744f6d8e8413a07aa70212c25dd9df085dae5f96d19',
      armv7l: 'c5617c8ad9ff0c9107a5a744f6d8e8413a07aa70212c25dd9df085dae5f96d19',
        i686: '4762713d801e19d3d61365e886fb99fe2349eeadb09c6a347c073bab97434721',
      x86_64: 'b34f4abe636e86709e0256bded03442782c637fb9c155cd954bb0952f8a339e3'
  })

  depends_on 'openssl'

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
