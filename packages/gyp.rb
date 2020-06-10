require 'package'

class Gyp < Package
  description 'GYP is a Meta-Build system: a build system that generates other build systems.'
  homepage 'https://gyp.gsrc.io/'
  version '81286d'
  compatibility 'all'
  source_url 'https://github.com/bnoordhuis/gyp/archive/81286d388abf5c8f946f3f4be274bd987a690952.tar.gz'
  source_sha256 'c99f4fb0ba0798492713cd19579af8140e9a65d32af62c56bd6d447cf1ab7f6a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gyp-81286d-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gyp-81286d-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gyp-81286d-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gyp-81286d-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '74c53919430e90aafd5301d815c8f161dc79822067e1381f7ed7116522eb8c93',
     armv7l: '74c53919430e90aafd5301d815c8f161dc79822067e1381f7ed7116522eb8c93',
       i686: '00f6bc5495648c67d1ddf35dca8bf382191be220861f027604d4aa4e4a33ac1a',
     x86_64: 'a6ad933e8dc00f2fc5baff2f5bf523040a7a427dbb5f4e59dd7cfc2e48c8388c',
  })

  depends_on 'python27' unless File.exists? "#{CREW_PREFIX}/bin/python"

  def self.install
    system "python setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
