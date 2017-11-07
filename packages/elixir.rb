require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.2'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.2/Precompiled.zip'
  source_sha256 '4ba8dd46998bee6cbcc2d9937776e241be82bc62d2b62b6235c310a44c87467e'

  binary_url ({
  })
  binary_sha256 ({
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
