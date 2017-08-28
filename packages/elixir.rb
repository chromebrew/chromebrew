require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.1'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.1/Precompiled.zip'
  source_sha256 '84af6eb4cb68d0f60b3edf4e275eb024f8eb8cccae91b18c2bbbc4b70a88934f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'erlang'
  depends_on 'unzip'

  def self.build
    # do noting
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mkdir -p #{CREW_DEST_DIR}#{CREW_PREFIX}/share"
    system "mv bin #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mv lib #{CREW_DEST_DIR}#{CREW_PREFIX}"
    system "mv man #{CREW_DEST_DIR}#{CREW_PREFIX}/share"
  end
end
