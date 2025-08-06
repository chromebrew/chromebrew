require 'package'

class Jitsi_meet < Package
  description 'Jitsi Meet video conferencing desktop application'
  homepage 'https://jitsi.org/jitsi-meet/'
  version '2025.4.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/jitsi/jitsi-meet-electron/releases/download/v#{version}/jitsi-meet-x86_64.AppImage"
  source_sha256 'f40bb056423151f18b7a17f04a5d64b82e5dbddfa89840b25aba0def6c48f29c'

  depends_on 'gtk3'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.patch
    system "sed -i 's,AppRun,jitsi,' jitsi-meet.desktop"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX.to_s
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jitsi"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}/share/jitsi"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.rm_rf 'usr'
    FileUtils.mv 'jitsi-meet.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/jitsi"
    File.write 'jitsi.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/jitsi
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
    FileUtils.install 'jitsi.sh', "#{CREW_DEST_PREFIX}/bin/jitsi", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'jitsi' to get started.\n".lightblue
  end

  def self.postremove
    config_dir = "#{CREW_PREFIX}/.config/Jitsi Meet"
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
