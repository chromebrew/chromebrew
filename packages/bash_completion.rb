require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.11'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion/archive/refs/tags/2.11.tar.gz'
  source_sha256 '16adefabf43ec8ffb473704f5724d775c2f47e9f750d7d608f0251ec21fe8813'

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
