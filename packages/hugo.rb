require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.59.0'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.59.0/hugo_0.59.0_Linux-ARM.tar.gz'
    source_sha256 'a9691059ece7598caf470e0b2c8793c1d7050a948ed5f32bc4ce0971b57a6381'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.59.0/hugo_0.59.0_Linux-32bit.tar.gz'
    source_sha256 '69ef32b40a139a43d456ede1b558d541d9df1cbe89a52956d81d242b2343020e'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.59.0/hugo_0.59.0_Linux-64bit.tar.gz'
    source_sha256 '4cce9411a29f1599119bbec0d253506cac753b559d5dd7ca7b3b6ce3a92c42ff'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
