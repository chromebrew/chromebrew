require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.82.1'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.82.1/hugo_0.82.1_Linux-ARM.tar.gz'
    source_sha256 '950943930b4c404d12660c67ce6eb109e1379e258958f9d177b3a6f86ec084cb'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.82.1/hugo_0.82.1_Linux-32bit.tar.gz'
    source_sha256 '469749ba6ac750a1f4a2e9bf505b1b79e3b84060a6f72ede16791f1530cc245f'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.82.1/hugo_extended_0.82.1_Linux-64bit.tar.gz'
    source_sha256 '09df1dfea2ee7e5b1a8bdc6aabbdf9baad5ac2d80034b2bd715e5c7230db99f7'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
