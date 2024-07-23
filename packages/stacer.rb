require 'package'

class Stacer < Package
  description 'Stacer is an open source system optimizer and application monitor'
  homepage 'https://oguzhaninan.github.io/Stacer-Web/'
  version '1.1.0'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/Stacer-1.1.0-x64.AppImage'
  source_sha256 '1a6a555d596ec978d54fbe1b924a4555c3a5b39b4f9bf17bc6efe31fcb178594'

  depends_on 'mesa'

  no_compile_needed

  def self.build
    File.write 'stacer.sh', <<~EOF
      #!/bin/bash
      export LD_LIBRARY_PATH=#{CREW_PREFIX}/share/stacer/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/stacer
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/stacer]
    FileUtils.install 'stacer.sh', "#{CREW_DEST_PREFIX}/bin/stacer", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/stacer"
  end

  def self.postinstall
    ExitMessage.add "\nType 'stacer' to get started."
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/stacer"
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
