require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '3.4.2-RC1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.29'
  source_url({
    aarch64: 'https://github.com/shiftkey/desktop/releases/download/release-3.4.2-linux1/GitHubDesktop-linux-armv7l-3.4.2-linux1.AppImage',
     armv7l: 'https://github.com/shiftkey/desktop/releases/download/release-3.4.2-linux1/GitHubDesktop-linux-armv7l-3.4.2-linux1.AppImage',
     x86_64: 'https://github.com/shiftkey/desktop/releases/download/release-3.4.2-linux1/GitHubDesktop-linux-x86_64-3.4.2-linux1.AppImage'
  })
  source_sha256({
    aarch64: '73a46b16bf8921a0037c17105e673d7414c5f53788916bf52b7f6299c3c4d26d',
     armv7l: '73a46b16bf8921a0037c17105e673d7414c5f53788916bf52b7f6299c3c4d26d',
     x86_64: 'a323ef799e342ebb015c21e82989f51671bfddd652e23821b8ce1032d93fbde0'
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
