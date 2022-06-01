require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'https://elixir-lang.org/'
  version '1.13.0'
  license 'Apache-2.0 and ErlPL-1.1'
  compatibility 'all'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.13.0/Precompiled.zip'
  source_sha256 'f287bebecaa40f91ff163ca86fbbedd40f05847dd57d217a5824d816e8e6750d'

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
