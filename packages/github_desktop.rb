require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '3.3.3-RC2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url({
    aarch64: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.3-linux2/GitHubDesktop-linux-armv7l-3.3.3-linux2.AppImage',
     armv7l: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.3-linux2/GitHubDesktop-linux-armv7l-3.3.3-linux2.AppImage',
     x86_64: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.3-linux2/GitHubDesktop-linux-x86_64-3.3.3-linux2.AppImage'
  })
  source_sha256({
    aarch64: '7080fd4b4e371e56b5bc49a0d66fe888f81884260283f181c0e33377810613b4',
     armv7l: '7080fd4b4e371e56b5bc49a0d66fe888f81884260283f181c0e33377810613b4',
     x86_64: 'c8b71fef885e903ff569273853c2848230a990e602d053b196443bdc3c7645a0'
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
    gd = <<~EOF
      #!/bin/bash
      GDK_BACKEND=x11
      cd #{CREW_PREFIX}/share/github_desktop
      ./AppRun "$@"
    EOF
    File.write('github-desktop.sh', gd)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/github_desktop"
    FileUtils.install 'github-desktop.sh', "#{CREW_DEST_PREFIX}/bin/github-desktop", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/github_desktop"
  end

  def self.postinstall
    puts "\nType 'github-desktop' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/GitHub\ Desktop"
    if Dir.exist? config_dir.to_s
      system "echo '#{config_dir}'; ls '#{config_dir}'"
      print "\nWould you like to remove the config directories above? [y/N] "
      case $stdin.gets.chomp.downcase
      when 'y', 'yes'
        FileUtils.rm_rf config_dir
        puts "'#{config_dir}' removed.".lightred
      else
        puts "'#{config_dir}' saved.".lightgreen
      end
    end
  end
end
