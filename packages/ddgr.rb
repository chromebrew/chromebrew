require 'package'

class Ddgr < Package
  description 'DuckDuckGo from the terminal'
  homepage 'https://github.com/jarun/ddgr'
  version '2.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/jarun/ddgr/archive/v2.0.tar.gz'
  source_sha256 '7e46430b0a8c479a5feca832adb73f2f09804bf603dedc50f4cf2e1da4c75f88'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.0_armv7l/ddgr-2.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.0_armv7l/ddgr-2.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.0_i686/ddgr-2.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/ddgr/2.0_x86_64/ddgr-2.0-chromeos-x86_64.tar.zst',
  })
  binary_sha256 ({
    aarch64: '9aeb15a4dd5259ec574689beb5ecfb28a3c8c0bfe33547e91c02264b148effc6',
     armv7l: '9aeb15a4dd5259ec574689beb5ecfb28a3c8c0bfe33547e91c02264b148effc6',
       i686: '91ca6233a9624c547f9d284354486f47115f4e1145e27d8975cd1089386a8626',
     x86_64: 'e630b4172a9cb45f55aad475f077bfd6b355c8f191cdc9ed51104e335c5c88cf',
  })

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
