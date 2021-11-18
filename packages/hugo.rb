require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.89.1'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.89.1/hugo_0.89.1_Linux-ARM.tar.gz'
    source_sha256 'd958a29e98b09888c7fb4bbe35665425cad0e2c604d3e65c1a669a40967f65fb'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.89.1/hugo_0.89.1_Linux-32bit.tar.gz'
    source_sha256 '6a9b37e45f61aea0c9b201943e749f2b729a55a70ff87b0ff69ed3149c031cc3'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.89.1/hugo_extended_0.89.1_Linux-64bit.tar.gz'
    source_sha256 'b540d7ec33366f52900f60b4ab3d08a0536222e16f2582819498dc034d69087c'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
