require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.68.1'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.68.1/hugo_0.68.1_Linux-ARM.tar.gz'
    source_sha256 '3d10e6630730761c6352d02ada31cefb196c42a9c0aca8a38f60d8215ff24f8b'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.68.1/hugo_0.68.1_Linux-32bit.tar.gz'
    source_sha256 'fe6c97026bcceb6d1c6f520f98cf211e9b17f39d1f51be4a0a0537871d1e7a2e'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.68.1/hugo_0.68.1_Linux-64bit.tar.gz'
    source_sha256 '7942cfed5b22f294cc95edbe7ac2d2fdf42a1c4ec94da4666b48256a850c9caa'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
