require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'http://elixir-lang.org/'
  version '1.5.0'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.5.0/Precompiled.zip'
  source_sha256 '01841d8f973e10ea2e8e29342193063efb5ebe2c598c21dc8a3b93ec8428466a'

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
