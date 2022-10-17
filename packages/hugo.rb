require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.98.0'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/gohugoio/hugo/releases/download/v0.98.0/hugo_0.98.0_Linux-ARM.tar.gz',
     armv7l: 'https://github.com/gohugoio/hugo/releases/download/v0.98.0/hugo_0.98.0_Linux-ARM.tar.gz',
       i686: 'https://github.com/gohugoio/hugo/releases/download/v0.98.0/hugo_0.98.0_Linux-32bit.tar.gz',
     x86_64: 'https://github.com/gohugoio/hugo/releases/download/v0.98.0/hugo_extended_0.98.0_Linux-64bit.tar.gz'
  })
  source_sha256({
    aarch64: 'abe9a29c675ddbb842b166c90cd6b4da23fa69eb95e6317cabb0ec25fc9766db',
     armv7l: 'abe9a29c675ddbb842b166c90cd6b4da23fa69eb95e6317cabb0ec25fc9766db',
       i686: '68593b70a03b9e534d1b71e350c87a701bc00a6c7e45851dcc632f1504e88a2d',
     x86_64: '66577b6aad435073bc9d16f5e12a83566d1ceafcdfb09e3f06045562216c69fc'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
