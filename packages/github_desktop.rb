require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '3.3.12-RC2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.29'
  source_url({
    aarch64: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.12-linux2/GitHubDesktop-linux-armv7l-3.3.12-linux2.AppImage',
     armv7l: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.12-linux2/GitHubDesktop-linux-armv7l-3.3.12-linux2.AppImage',
     x86_64: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.12-linux2/GitHubDesktop-linux-x86_64-3.3.12-linux2.AppImage'
  })
  source_sha256({
    aarch64: 'a24c9adaca3ea2298489bb86a6b763a3b167d67cb76e626cd7d220b078cc4a09',
     armv7l: 'a24c9adaca3ea2298489bb86a6b763a3b167d67cb76e626cd7d220b078cc4a09',
     x86_64: 'f093bf1768b53fb03edafd1731ff6ca5a88254ba32c35b5992d4d63b634572de'
  })

  depends_on 'at_spi2_core'
  depends_on 'gdk_pixbuf'
  depends_on 'libcom_err'
  depends_on 'xdg_base'
  depends_on 'gtk3'

  no_compile_needed
  no_shrink
  no_strip # Fixes Syntax error: redirection unexpected (expecting ")")

  def self.build
    File.write 'github-desktop.sh', <<~EOF
      #!/bin/bash
      GDK_BACKEND=x11
      cd #{CREW_PREFIX}/share/github_desktop
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/github_desktop"
    FileUtils.install 'github-desktop.sh', "#{CREW_DEST_PREFIX}/bin/github-desktop", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/github_desktop"
  end

  def self.postinstall
    ExitMessage.add "\nType 'github-desktop' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/GitHub\ Desktop"
    if Dir.exist? config_dir.to_s
      puts config_dir
      system "ls '#{config_dir}'"
      print "\nWould you like to remove the config directories above? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "'#{config_dir}' removed.".lightgreen
      else
        puts "'#{config_dir}' saved.".lightgreen
      end
    end
  end
end
