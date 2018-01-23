require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.3'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.3/Precompiled.zip'
  source_sha256 '70972b844c12bc1a3960136d628ab4f21ca87dd5539c544ebabe41d6c9239ba9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b2766a7b79e4fcb715604d9fbedbd347b6a7b797d2ff09c76e6b6e35d74eb80',
     armv7l: '5b2766a7b79e4fcb715604d9fbedbd347b6a7b797d2ff09c76e6b6e35d74eb80',
       i686: 'df2a3c7a938b52c07b31e9d4028c3aba2b7f24bba20d62ecc17262dc7f72dd50',
     x86_64: '7a71cc9069e87ae71d5dbdff6ea5580befe78803237822b4828289280e4fd7de',
  })

  depends_on 'erlang'
  depends_on 'unzip' => :build

  def self.build
    # do nothing
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "mkdir -p #{CREW_DEST_PREFIX}/share"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/* #{CREW_DEST_LIB_PREFIX}"
    system "cp -r man/ #{CREW_DEST_PREFIX}/share"
  end
end
