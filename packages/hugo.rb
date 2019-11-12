require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.59.1'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-ARM.tar.gz'
    source_sha256 'e724d51908461bc2d88dbba6ca59dc8325dc6f28b437a04b668cc54ee3e243fb'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-32bit.tar.gz'
    source_sha256 '0ef610f0aeb8a6bf25a0744fc462ac7da00dcb01853ab9d65444fb9691fcfdc5'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-64bit.tar.gz'
    source_sha256 'b92c47a705ad372887454644f8bee76caa6234be13c073834827b58f73fb7adb'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
