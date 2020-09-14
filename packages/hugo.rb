require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.75.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.75.0/hugo_0.75.0_Linux-ARM.tar.gz'
    source_sha256 '5d39a0e0c9ca1228c6bfbba32c1e2e5f467654235273f09b309cff6803777f6b'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.75.0/hugo_0.75.0_Linux-32bit.tar.gz'
    source_sha256 '59683e287198ef5ea86c1f3a070f51613732096a69b2746a74b6f34289c51482'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.75.0/hugo_extended_0.75.0_Linux-64bit.tar.gz'
    source_sha256 'f2cd128b877b15f695fbd64167cf1b414849886113845228a8247ca54a6acf13'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
