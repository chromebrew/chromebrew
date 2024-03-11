require 'package'

class Makedepend < Package
  description 'Makedepend parses C sources in Makefiles to generate dependency lists'
  homepage 'https://www.x.org/'
  version '1.0.6'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.x.org/releases/individual/util/makedepend-1.0.6.tar.gz'
  source_sha256 '845f6708fc850bf53f5b1d0fb4352c4feab3949f140b26f71b22faba354c3365'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'cdae9433b0ce1dbf949eac2ba2ccf48561ee1357e3f63b28b76c70eeaecedaa3',
     armv7l: 'cdae9433b0ce1dbf949eac2ba2ccf48561ee1357e3f63b28b76c70eeaecedaa3',
     x86_64: 'e4206936533ceacd2cef5c93b42ef119d11339e9faf0a381a4b0c7b950124cea'
  })

  depends_on 'libx11'

  def self.build
    system "./configure #{CREW_OPTIONS} \
              --without-lint"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
