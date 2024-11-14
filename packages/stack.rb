require 'package'

class Stack < Package
  description 'The Haskell Tool Stack - Stack is a cross-platform program for developing Haskell projects. It is aimed at Haskellers both new and experienced.'
  homepage 'https://docs.haskellstack.org/'
  version '2.15.7'
  license 'BSD'
  compatibility 'x86_64'
  source_url "https://github.com/commercialhaskell/stack/releases/download/v#{version}/stack-#{version}-linux-x86_64-bin"
  source_sha256 '70fdbbcb368275673fb8ce8a3d1c1c907b239454b900c87220743f1998e47a1c'

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install "stack-#{version}-linux-#{ARCH}-bin", "#{CREW_DEST_PREFIX}/bin/stack", mode: 0o755

    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.stack"
    File.write "#{CREW_DEST_HOME}/.stack/config.yaml", <<~EOF
      local-bin-path: #{CREW_PREFIX}/bin
      local-programs-path: #{CREW_PREFIX}/share/stack
    EOF

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    File.write "#{CREW_DEST_PREFIX}/etc/bash.d/10-stack", <<~EOF
      # Haskell stack bash completion
      eval "$(stack --bash-completion-script stack)"
    EOF
  end

  def self.postremove
    config_dir = "#{CREW_PREFIX}/share/stack"
    if Dir.exist? config_dir
      print "Would you like to remove the #{config_dir} directory? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "#{config_dir} removed.".lightgreen
      else
        puts "#{config_dir} saved.".lightgreen
      end
    end
  end
end
