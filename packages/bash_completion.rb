require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.9-1-1'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion/archive/2.9.tar.gz'
  source_sha256 'fddd9e6739c972eea95d1f0e0e84fa9a17a5935ba21eab37308b27580cc4d790'

  def self.build
    system 'autoreconf -i'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # Bash completion configuration
      source #{CREW_PREFIX}/share/bash-completion/bash_completion
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/bash_completion", @env)
  end
end
