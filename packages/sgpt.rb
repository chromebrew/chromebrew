require 'package'

class Sgpt < Package
  description 'SGPT is a command-line tool that provides a convenient way to interact with OpenAI models'
  homepage 'https://github.com/tbckr/sgpt'
  version '2.20.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url({
    aarch64: "https://github.com/tbckr/sgpt/releases/download/v#{version}/sgpt_Linux_armv7.tar.gz",
     armv7l: "https://github.com/tbckr/sgpt/releases/download/v#{version}/sgpt_Linux_armv7.tar.gz",
     x86_64: "https://github.com/tbckr/sgpt/releases/download/v#{version}/sgpt_Linux_x86_64.tar.gz"
  })
  source_sha256({
    aarch64: '884e3471a774f2765dfd615b23c63444662fc0c8c3c4f233f1197c51d9b35bd2',
     armv7l: '884e3471a774f2765dfd615b23c63444662fc0c8c3c4f233f1197c51d9b35bd2',
     x86_64: '4d1d4bfd726f0df9bab6fe9fc295aee4a23e268b9ab07faa0b466b18083874e5'
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
