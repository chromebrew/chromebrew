require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '3.4.3-linux1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  min_glibc '2.29'
  source_url({
    aarch64: "https://github.com/shiftkey/desktop/releases/download/release-#{version}/GitHubDesktop-linux-armv7l-#{version}.AppImage",
     armv7l: "https://github.com/shiftkey/desktop/releases/download/release-#{version}/GitHubDesktop-linux-armv7l-#{version}.AppImage",
     x86_64: "https://github.com/shiftkey/desktop/releases/download/release-#{version}/GitHubDesktop-linux-x86_64-#{version}.AppImage"
  })
  source_sha256({
    aarch64: '82f66728d77ea66bcd9ed6cdb24787daa8ee2e6eeed0a11f4e8c5a0ea01ee8b8',
     armv7l: '82f66728d77ea66bcd9ed6cdb24787daa8ee2e6eeed0a11f4e8c5a0ea01ee8b8',
     x86_64: 'ee16174d1ae3f39cd856cfdf8e9ad2015568b99746966c95825b61e9bb5d6bdf'
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
    ExitMessage.add "\nType 'github-desktop' to get started.\n"
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
