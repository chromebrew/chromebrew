require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.64.0'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.64.0/hugo_0.64.0_Linux-ARM.tar.gz'
    source_sha256 '361fc16073a80e35d026b12a009eae4b18d3574f1a74f8c598255c7eeac26276'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.64.0/hugo_0.64.0_Linux-32bit.tar.gz'
    source_sha256 '17ebcc9ee1bf1b39eb3ae1bdb9dfba2d5e12f503d2eeed45a269a651d623d955'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.64.0/hugo_0.64.0_Linux-64bit.tar.gz'
    source_sha256 '99c4752bd46c72154ec45336befdf30c28e6a570c3ae7cc237375cf116cba1f8'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
