require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'https://elixir-lang.org/'
  version '1.12.0'
  license 'Apache-2.0 and ErlPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.12.0/Precompiled.zip'
  source_sha256 '20f000703406b3ea7004b7c732f772bdb431151f6c064fe7e48a47d2ada552d6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'erlang'

  def self.install
    # Remove unused files
    FileUtils.rm 'man/common'
    FileUtils.rm 'bin/mix.ps1'
    FileUtils.rm 'bin/.DS_Store'
    FileUtils.rm Dir['bin/*.bat']
    FileUtils.rm Dir['man/*.1.in']
    # Prepare destination directories
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    # Add relevant files
    FileUtils.cp_r 'bin/', "#{CREW_DEST_PREFIX}"
    FileUtils.cp_r Dir['lib/mix/lib/*'], "#{CREW_DEST_LIB_PREFIX}"
    FileUtils.cp_r Dir['man/*'], "#{CREW_DEST_MAN_PREFIX}/man1"
  end
end
