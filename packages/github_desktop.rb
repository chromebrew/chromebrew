require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '2.9.6-RC'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/shiftkey/desktop/releases/download/release-2.9.6-linux1/GitHubDesktop-linux-2.9.6-linux1.AppImage'
  source_sha256 'e5187e7c5a9ad1fa3c110c1ec60c9e7f75e0792c3670907741243f7cbea831b0'

  binary_url({})
  binary_sha256({})

  depends_on 'at_spi2_core'
  depends_on 'gdk_pixbuf'
  depends_on 'libcom_err'
  depends_on 'xdg_base'
  depends_on 'sommelier'

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
