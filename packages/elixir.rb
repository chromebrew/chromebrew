require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'https://elixir-lang.org/'
  version '1.9.1'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.9.1/Precompiled.zip'
  source_sha256 '17e43cb1627a0fa5625bc370cec0964ad6471ef242f1549e316db73c0d94fcc6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'erlang'
  depends_on 'unzip' => :build

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    system "cp -r bin/ #{CREW_DEST_PREFIX}"
    system "cp -r lib/* #{CREW_DEST_LIB_PREFIX}"
    system "cp -r man/ #{CREW_DEST_PREFIX}/share"
  end
end
