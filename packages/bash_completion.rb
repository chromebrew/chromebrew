require 'package'

class Bash_completion < Package
  description 'Programmable completion functions for bash'
  homepage 'https://github.com/scop/bash-completion'
  version '2.11'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/scop/bash-completion/archive/refs/tags/2.11.tar.gz'
  source_sha256 '16adefabf43ec8ffb473704f5724d775c2f47e9f750d7d608f0251ec21fe8813'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/bash_completion-2.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/bash_completion-2.11-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/bash_completion-2.11-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/bash_completion-2.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dc426ff82ec4b0feb70d9a8b271269873127f95a5f8b8cde27c4aa38468afd27',
     armv7l: 'dc426ff82ec4b0feb70d9a8b271269873127f95a5f8b8cde27c4aa38468afd27',
       i686: '35c16db77e47df16451bfd3ecc9759c6debe9e74523a3644cf47fbc3b211fa3e',
     x86_64: '75f84fe83ae7e4c308dc62ea26a1dffd886f1efe486f0ed9ba8587ee3e7f42bc'
  })

  def self.build
    system 'autoreconf -i'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @bashcompletionenv = <<~BASHCOMPLETIONEOF
      # Bash completion configuration
      source #{CREW_PREFIX}/share/bash-completion/bash_completion
    BASHCOMPLETIONEOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/bash_completion", @bashcompletionenv)
  end
end
