require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '3.3.6-RC2'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.29'
  source_url({
    aarch64: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.6-linux2/GitHubDesktop-linux-armv7l-3.3.6-linux2.AppImage',
     armv7l: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.6-linux2/GitHubDesktop-linux-armv7l-3.3.6-linux2.AppImage',
     x86_64: 'https://github.com/shiftkey/desktop/releases/download/release-3.3.6-linux2/GitHubDesktop-linux-x86_64-3.3.6-linux2.AppImage'
  })
  source_sha256({
    aarch64: '4508fcbc680408a183fbd00f172e5beccad414e503cefd77163bffff0bd1a31c',
     armv7l: '4508fcbc680408a183fbd00f172e5beccad414e503cefd77163bffff0bd1a31c',
     x86_64: 'fe0e8689886939247819dc0ae3d1f242ade555e4990c3ede045ba3493514d250'
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
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/github_desktop"
    FileUtils.install 'github-desktop.sh', "#{CREW_DEST_PREFIX}/bin/github-desktop", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/github_desktop"
  end

  def self.postinstall
    ExitMessage.add "Type 'github-desktop' to get started.".lightblue
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
