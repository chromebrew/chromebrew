require 'package'

class Unixodbc < Package
  description 'ODBC is an open specification for providing application developers with a predictable API with which to access Data Sources.'
  homepage 'http://www.unixodbc.org/'
  version '2.3.9'
  license 'LGPL-2+'
  compatibility 'all'
  source_url "http://www.unixodbc.org/unixODBC-#{version}.tar.gz"
  source_sha256 '52833eac3d681c8b0c9a5a65f2ebd745b3a964f208fc748f977e44015a31b207'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unixodbc/2.3.9_armv7l/unixodbc-2.3.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unixodbc/2.3.9_armv7l/unixodbc-2.3.9-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unixodbc/2.3.9_i686/unixodbc-2.3.9-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/unixodbc/2.3.9_x86_64/unixodbc-2.3.9-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6f04ee2e7fcc4e8c37db45e05fe51a5dcac345b7c61d440b791762ae7609b578',
     armv7l: '6f04ee2e7fcc4e8c37db45e05fe51a5dcac345b7c61d440b791762ae7609b578',
       i686: '590762ad9a2cd402ae52da0382c652d8e08a6b049f875ae99ec792f228331cd8',
     x86_64: '705488db5fc32fe2062da25e4650ac090983404525c9d06f32646058a76cfb2a'
  })

  def self.build
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
