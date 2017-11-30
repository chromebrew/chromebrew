require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.2'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.2/Precompiled.zip'
  source_sha256 '4ba8dd46998bee6cbcc2d9937776e241be82bc62d2b62b6235c310a44c87467e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/elixir-1.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c7bead1be6e342db90aa661af0997776fdb432067ba5447ecdc4163eec64e352',
     armv7l: 'c7bead1be6e342db90aa661af0997776fdb432067ba5447ecdc4163eec64e352',
       i686: 'bbdd12c822fcd0e23d8b9261b70a1dbea9bf57a9bb5e1d7f49c6d499cfb0a718',
     x86_64: '3ae46775194644acb590d8e50864ff4d00d24f7988177d270d9371dab87bea37',
  })

  depends_on 'erlang'
  depends_on 'unzip' => :build

  def self.build
    # do noting
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}"
    system "mkdir -p #{CREW_DEST_PREFIX}/share"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "mv bin #{CREW_DEST_PREFIX}"
    system "mv lib #{CREW_DEST_LIB_PREFIX}"
    system "mv man #{CREW_DEST_PREFIX}/share"
  end
end
