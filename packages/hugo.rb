require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.62.1'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.62.1/hugo_0.62.1_Linux-ARM.tar.gz'
    source_sha256 '7c7ed6995afd9d6468532b79e53a31a1a865aaa329a3c588f044527a156a70c7'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.62.1/hugo_0.62.1_Linux-32bit.tar.gz'
    source_sha256 '4c5bf7e23575dac1639d14775550a5963e177f2aad48ce5dee6ea300903c75b9'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.62.1/hugo_0.62.1_Linux-64bit.tar.gz'
    source_sha256 '7946ce9b3b6d48d9e218d556010df0fa031b19fc1616d04e96f183325e3123c0'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
