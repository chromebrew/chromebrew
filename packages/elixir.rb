require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'https://elixir-lang.org/'
  version '1.18.3'
  license 'Apache-2.0 and ErlPL-1.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/elixir-lang/elixir.git'
  git_hashtag "v#{version}"

  depends_on 'erlang'

  no_compile_needed

  def self.install
    # Remove unused files
    FileUtils.rm_f 'man/common'
    FileUtils.rm_f 'bin/mix.ps1'
    FileUtils.rm_f Dir['bin/*.bat']
    FileUtils.rm_f Dir['man/*.1.in']
    # Prepare destination directories
    FileUtils.mkdir_p CREW_DEST_LIB_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    # Add relevant files
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv Dir['lib/mix/lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.mv Dir['man/*'], "#{CREW_DEST_MAN_PREFIX}/man1"
  end
end
