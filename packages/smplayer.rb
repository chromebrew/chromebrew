require 'package'

class Smplayer < Package
  description 'SMPlayer is a free media player for Windows and Linux with built-in codecs that can play virtually all video and audio formats.'
  homepage 'https://www.smplayer.info/'
  version '24.5.0'
  license 'GPL-2'
  compatibility 'x86_64'
  min_glibc '2.30'
  source_url "https://github.com/smplayer-dev/smplayer/releases/download/v#{version}/SMPlayer-#{version}-x86_64.AppImage"
  source_sha256 '85fb5a2322f48a298b7784fc3516e672525593c017ca504310bff05e1330457b'

  no_compile_needed

  depends_on 'gdk_base'
  depends_on 'gtk3'
  depends_on 'jack'
  depends_on 'libthai'
  depends_on 'sommelier'

  def self.build
    File.write 'smplayer', <<~EOF
      #!/bin/bash
      export LD_LIBRARY_PATH=#{CREW_PREFIX}/share/smplayer/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/smplayer
      bin/smplayer "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/smplayer"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/icons/hicolor/512x512/apps"
    FileUtils.mv Dir['usr/*'], "#{CREW_DEST_PREFIX}/share/smplayer"
    FileUtils.mv 'smplayer.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'smplayer.svg', "#{CREW_DEST_PREFIX}/share/icons/hicolor/512x512/apps"
    FileUtils.install 'smplayer', "#{CREW_DEST_PREFIX}/bin/smplayer", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add <<~EOM

      Type 'smplayer' to get started.

      If you have trouble playing videos, try the steps below:
      Select Options > Preferences
      Click the 'Audio' tab
      Uncheck 'Use software volume control'
      Click OK
    EOM
  end

  def self.postremove
    config_dir = "#{CREW_PREFIX}/.config/smplayer"
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
