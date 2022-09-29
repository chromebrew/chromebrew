require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.3'
  version @_ver
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 'f3ac987522c00d33d44b323cae424e2cffcb4c63c6aa6cd1376edacbf1c36eb0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3_armv7l/libidn2-2.3.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3_armv7l/libidn2-2.3.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3_i686/libidn2-2.3.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3_x86_64/libidn2-2.3.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '506044ffa75da19775112ad71b62c1531b9b272304ece0d250891b7df73dd298',
     armv7l: '506044ffa75da19775112ad71b62c1531b9b272304ece0d250891b7df73dd298',
       i686: 'f8b784f50e9cb56f73f78520a0712e6dceba66316a86571f3aa4165daab02a4f',
     x86_64: '7c5c25b5028ec8c1a4e8ae7b525959b1130e4118e10233238ce96adf51938809'
  })

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
