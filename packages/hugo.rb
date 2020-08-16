require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.74.3'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.74.3/hugo_0.74.3_Linux-ARM.tar.gz'
    source_sha256 '7028f14d3f2048dfee6dd665ddde230bf1901fe39830d502c641f7dc06db7577'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.74.3/hugo_0.74.3_Linux-32bit.tar.gz'
    source_sha256 '9089e1edf55c2534bb2b0cb80d5916f4d157a1ebf821b591e9dcf6109e8b220e'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.74.3/hugo_extended_0.74.3_Linux-64bit.tar.gz'
    source_sha256 'f9aadb70d1edb2a82cefb866acb717ebaa12f3a7f008e589495a142567669b57'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
