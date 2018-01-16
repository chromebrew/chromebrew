require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.3'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.3/Precompiled.zip'
  source_sha256 '70972b844c12bc1a3960136d628ab4f21ca87dd5539c544ebabe41d6c9239ba9'

  binary_url ({
  })
  binary_sha256 ({
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
