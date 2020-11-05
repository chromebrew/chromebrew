require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.78.1'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.78.1/hugo_0.78.1_Linux-ARM.tar.gz'
    source_sha256 '0740e70cc762df393d62c60cb18e660a0ea56a065d8acc731612cbd11e3d9372'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.78.1/hugo_0.78.1_Linux-32bit.tar.gz'
    source_sha256 '696905065f4383acbd7b648db91a201203f8946757ae44a89c919231df66e813'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.78.1/hugo_extended_0.78.1_Linux-64bit.tar.gz'
    source_sha256 '145a4c14003c841ec5c194b361e4a16b463514df1348c1b11a9af76fd727f338'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
