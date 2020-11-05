require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.78.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.78.0/hugo_0.78.0_Linux-ARM.tar.gz'
    source_sha256 'c8908c5b1374e8d66715f28cefc12ce0f1dd6239d64ddfd8e978ba854b18742d'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.78.0/hugo_0.78.0_Linux-32bit.tar.gz'
    source_sha256 '7790f603ebf66d0a3d5fd175bded159e4a227e8a49ddeb80c02faff387815c13'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.78.0/hugo_extended_0.78.0_Linux-64bit.tar.gz'
    source_sha256 '2c3d888439765d10d0713a197681c4ecd06c1aa14367d8f4eb3ad69f64c9714b'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
