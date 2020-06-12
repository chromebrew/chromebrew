require 'package'

class Virtualenv < Package
  description 'Virtual Python Environment builder'
  homepage 'http://virtualenv.pypa.io/'
  version '16.0.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/virtualenv/archive/16.0.0.tar.gz'
  source_sha256 '5a597f845cf785d46c3ae39d6cb18ef0b6af4ca366da40682364f78f7fe00d22'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/virtualenv-16.0.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/virtualenv-16.0.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/virtualenv-16.0.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/virtualenv-16.0.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9399ce601f4676f9d7803e4f8198db69503b0f1103e4224f3154d162801543e',
     armv7l: 'e9399ce601f4676f9d7803e4f8198db69503b0f1103e4224f3154d162801543e',
       i686: '74d7b88a32424d818b5c9ef4d8dfbdf7e3db7b422f84ed440e7c13f6ab1517a9',
     x86_64: 'bd8b5a48aadf9457287f95b5c99f33f0263fb3fbb026b1509affe46ed21faa9d',
  })

  def self.install
    system "python3 setup.py install --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end
end
