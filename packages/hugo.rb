require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.63.2'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.63.2/hugo_0.63.2_Linux-ARM.tar.gz'
    source_sha256 'a3b659ef0129582aa0151afa8e9727b3a740973727e3c2c4842e0814b85171bf'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.63.2/hugo_0.63.2_Linux-32bit.tar.gz'
    source_sha256 '229e297e45f890073d7a8c84c14a2ec54b0ea5d0fd9761e7339501a1f1cead07'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.63.2/hugo_0.63.2_Linux-64bit.tar.gz'
    source_sha256 '9f4d259c345ae976063d8a6064b8fa589a48280ab61c24cb0d1152cf077e4724'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
