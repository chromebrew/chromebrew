require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.76.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.76.0/hugo_0.76.0_Linux-ARM.tar.gz'
    source_sha256 '023bbc12c699a90f5626a406e999038ac56f446751a3ffc013529ce47fceeea3'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.76.0/hugo_0.76.0_Linux-32bit.tar.gz'
    source_sha256 'ba367fcae4cef1c7aedfc367d30b44aafa92cf7ffd73c478fedb0b58a9e4d8df'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.76.0/hugo_extended_0.76.0_Linux-64bit.tar.gz'
    source_sha256 'a30cab097d216cc8dd0d76a93413cf01cb8d0ca32d91c62941cc371b07f55bb9'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
