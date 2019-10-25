require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.58.3'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.58.3/hugo_0.58.3_Linux-ARM.tar.gz'
    source_sha256 '91f197b438fb4c7b359eecab55adc0a31876a27f619cbd5c64278ba0a24ecfd4'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.58.3/hugo_0.58.3_Linux-32bit.tar.gz'
    source_sha256 '380244636f81a717ac8ec1a17f4bca47724563cc1aca5f7746c1ed3c3a8c2e66'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.58.3/hugo_0.58.3_Linux-64bit.tar.gz'
    source_sha256 '92aeeb64d4c392782cb55424dc2cc594a06ad5e1bc7e156480feab488ff7e774'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
