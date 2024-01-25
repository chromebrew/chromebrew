require 'package'

class Libmodplug < Package
  description 'A MOD playing library'
  homepage 'http://modplug-xmms.sourceforge.net/'
  version '0.8.9.0-1'
  compatibility 'all'
  license 'public-domain'
  source_url 'https://downloads.sourceforge.net/modplug-xmms/libmodplug-0.8.9.0.tar.gz'
  source_sha256 '457ca5a6c179656d66c01505c0d95fafaead4329b9dbaa0f997d00a3508ad9de'
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'fd7b70d7e739910c13fcc14c1064c87d8824adea98f709be46e730cd0b21f2d3',
      armv7l: 'fd7b70d7e739910c13fcc14c1064c87d8824adea98f709be46e730cd0b21f2d3',
        i686: '2ae9edf8e240eb3c2f878d3f547ec2749fc19c00f3d5ad52b6760d541500a739',
      x86_64: '4e6e48ce53a6008c438ef69ebe54de75257e825bda156b539204f67c9f359b51'
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
