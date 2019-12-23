require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.61.0'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.61.0/hugo_0.61.0_Linux-ARM.tar.gz'
    source_sha256 'e33342d907a6744f4f90b96e99b700a3a72e424d1c94594e2d774fa2b43da52f'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.61.0/hugo_0.61.0_Linux-32bit.tar.gz'
    source_sha256 '39469894c2b337b9d906ae798ce3b3326c9d4dc8fad79d429b8f5e6ccc5ddd4f'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.61.0/hugo_0.61.0_Linux-64bit.tar.gz'
    source_sha256 '873e4a0fb39cbf17258ebd5ab54577652580ce7421b440f30e5cae9eafc731e4'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
