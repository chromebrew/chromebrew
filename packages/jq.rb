require 'package'

class Jq < Package
  description 'jq is a lightweight and flexible command-line JSON processor.'
  homepage 'https://stedolan.github.io/jq/'
  version '1.6-1'
  license 'MIT and CC-BY-3.0'
  compatibility 'all'
  source_url 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-1.6.tar.gz'
  source_sha256 '5de8c8e29aaa3fb9cc6b47bb27299f271354ebb72514e3accadc7d38b5bbaa72'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-1_armv7l/jq-1.6-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-1_armv7l/jq-1.6-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-1_i686/jq-1.6-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/jq/1.6-1_x86_64/jq-1.6-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6540447d8276d2485a2fe2d6f2a9837ab5fcf11609d55f64756af205e88e74b7',
     armv7l: '6540447d8276d2485a2fe2d6f2a9837ab5fcf11609d55f64756af205e88e74b7',
       i686: '68b25442f0f72f363365d3f436892a012aabadb1cc46ce91a0b10ed83468600c',
     x86_64: 'ca1c96623283110b69acedbde1e8cab9f01525e4a11f33249687f23f8e6b1959'
  })

  depends_on 'oniguruma'

  def self.build
    system 'filefix'
    system "env #{CREW_ENV_OPTIONS}  \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --disable-docs" # there's no support for manpages
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
