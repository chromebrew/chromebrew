require 'package'

class Elixir < Package
  description 'Elixir is a dynamic, functional language designed for building scalable and maintainable applications.'
  homepage 'https://elixir-lang.org/'
  version '1.13.4'
  license 'Apache-2.0 and ErlPL-1.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/elixir-lang/elixir/releases/download/v1.13.4/Precompiled.zip'
  source_sha256 'e74eee9d4e1c64e7add0e2b4e2fb41aaaa7450522f46f8e922b9bf6a27587606'

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
    FileUtils.cp_r 'bin/', CREW_DEST_PREFIX
    FileUtils.cp_r Dir['lib/mix/lib/*'], CREW_DEST_LIB_PREFIX
    FileUtils.cp_r Dir['man/*'], "#{CREW_DEST_MAN_PREFIX}/man1"
  end
end
