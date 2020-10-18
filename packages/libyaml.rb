require 'package'

class Libyaml < Package
  description 'LibYAML is a YAML parser and emitter library.'
  homepage 'https://pyyaml.org/wiki/LibYAML'
  version '0.2.5'
  compatibility 'all'
  source_url 'https://github.com/yaml/libyaml/releases/download/0.2.5/yaml-0.2.5.tar.gz'
  source_sha256 'c642ae9b75fee120b2d96c712538bd2cf283228d2337df2cf2988e3c02678ef4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libyaml-0.2.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libyaml-0.2.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libyaml-0.2.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libyaml-0.2.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c05fef7ea3a1d11e1cf5a95eb537f705b5999b07a2c892cc0145808a70d07200',
     armv7l: 'c05fef7ea3a1d11e1cf5a95eb537f705b5999b07a2c892cc0145808a70d07200',
       i686: '5a65d7491f853b9efebb6cc2c119daf28259bbb2e92ee38ce9d802b305d61fda',
     x86_64: '157e3e7c7dad0cea905a78944270b7b1fdd58bd363eeb167784a6d90a8c362b8',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
