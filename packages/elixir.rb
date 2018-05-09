require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.6.4'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.6.4/Precompiled.zip'
  source_sha256 '3a081c07d8ea2ce6620201e2689ce1fac0ee937ba5c13670cbaa40349e1581ab'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.6.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.6.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.6.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.6.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '364edfd964978f230f46721455665d17f6a09a6e7625b20f7fd504cb0208feba',
     armv7l: '364edfd964978f230f46721455665d17f6a09a6e7625b20f7fd504cb0208feba',
       i686: '65fb9c5bd16fdceb421200ad88d1aa7fc6a1facaef7fac3f054c12770582533e',
     x86_64: '1d185f98a47c2924ba747521bf46781bc36846953cfa8a81818f39f03c7d6013',
  })

  depends_on 'erlang'
  depends_on 'unzip' => :build

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "mkdir -p #{CREW_DEST_PREFIX}/share"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/* #{CREW_DEST_LIB_PREFIX}"
    system "cp -r man/ #{CREW_DEST_PREFIX}/share"
  end
end
