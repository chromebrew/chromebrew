require 'package'

class Makedepend < Package
  description 'Makedepend parses C sources in Makefiles to generate dependency lists'
  homepage 'https://www.x.org/'
  version '1.0.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/util/makedepend-1.0.6.tar.gz'
  source_sha256 '845f6708fc850bf53f5b1d0fb4352c4feab3949f140b26f71b22faba354c3365'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/makedepend/1.0.6_armv7l/makedepend-1.0.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/makedepend/1.0.6_armv7l/makedepend-1.0.6-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/makedepend/1.0.6_i686/makedepend-1.0.6-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/makedepend/1.0.6_x86_64/makedepend-1.0.6-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'cdae9433b0ce1dbf949eac2ba2ccf48561ee1357e3f63b28b76c70eeaecedaa3',
     armv7l: 'cdae9433b0ce1dbf949eac2ba2ccf48561ee1357e3f63b28b76c70eeaecedaa3',
       i686: 'c66619549ef4a3b57aff4178002efaabad1e0a3aa7424eb92aa510b1ee0e7d5d',
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
