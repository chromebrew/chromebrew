require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.69.0'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.69.0/hugo_0.69.0_Linux-ARM.tar.gz'
    source_sha256 '3c8b5159f2072bb44ac8fb8f5f75d7e9d8fad26aea079c81da3b026f94fb5266'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.69.0/hugo_0.69.0_Linux-32bit.tar.gz'
    source_sha256 '31dd00e1e35944e3ba7a019b453771dd1e0c389773aea00c48a83aa1d59bf866'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.69.0/hugo_0.69.0_Linux-64bit.tar.gz'
    source_sha256 '4a11fbce51cfabaa26a244d75e84ff16c7f9fd47c315e6f11f3f39612d82ba46'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
