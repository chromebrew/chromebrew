require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'https://elixir-lang.org/'
  version '1.9.1-1'
  compatibility 'all'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.9.1/Precompiled.zip'
  source_sha256 '17e43cb1627a0fa5625bc370cec0964ad6471ef242f1549e316db73c0d94fcc6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'erlang'
  depends_on 'unzip' => :build

  def self.install
    # Remove unused files
    FileUtils.rm 'man/common'
    FileUtils.rm 'bin/mix.ps1'
    FileUtils.rm 'bin/.DS_Store'
    FileUtils.rm Dir.glob('bin/*.bat')
    FileUtils.rm Dir.glob('man/*.1.in')
    # Prepare destination directories
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    # Add relevant files
    FileUtils.cp_r 'bin/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r Dir.glob('lib/mix/lib/*'), "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r Dir.glob('man/*'), "#{CREW_DEST_PREFIX}/share/man/man1"
  end
end
