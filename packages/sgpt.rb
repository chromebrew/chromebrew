require 'package'

class Sgpt < Package
  description 'SGPT is a command-line tool that provides a convenient way to interact with OpenAI models'
  homepage 'https://github.com/tbckr/sgpt'
  version '2.21.3'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/tbckr/sgpt/releases/download/v#{version}/sgpt_Linux_armv7.tar.gz",
     armv7l: "https://github.com/tbckr/sgpt/releases/download/v#{version}/sgpt_Linux_armv7.tar.gz",
     x86_64: "https://github.com/tbckr/sgpt/releases/download/v#{version}/sgpt_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: 'b292e0fab81f594cf798cd1413c608824abcbf788d8eccd547000b1982bdf8db',
     armv7l: 'b292e0fab81f594cf798cd1413c608824abcbf788d8eccd547000b1982bdf8db',
     x86_64: 'e9a802a63b018a323991237d8243fcea33014c61faee2e9e10569443d72248ac'
  })

  no_compile_needed
  print_source_bashrc

  def self.build
    File.write 'sgpt.bash', <<~EOF
      #!/bin/bash
      source #{CREW_PREFIX}/share/sgpt/completions/sgpt.bash
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sgpt"
    FileUtils.mv 'completions', "#{CREW_DEST_PREFIX}/share/sgpt"
    FileUtils.mv Dir['manpages/*'], "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.install 'sgpt', "#{CREW_DEST_PREFIX}/bin/sgpt", mode: 0o755
    FileUtils.install 'sgpt.bash', "#{CREW_DEST_PREFIX}/etc/env.d/10-sgpt", mode: 0o644
  end

  def self.postinstall
    ExitMessage.add "\nType 'sgpt -h' to get started.\n"
  end
end
