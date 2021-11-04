require 'package'

class Github_desktop < Package
  description 'GitHub Desktop is an open source Electron-based GitHub app'
  homepage 'https://desktop.github.com/'
  version '2.9.4-RC1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/shiftkey/desktop/releases/download/release-2.9.4-linux1/GitHubDesktop-linux-2.9.4-linux1.AppImage'
  source_sha256 'a47a987e091f9cd07ac8f71a42f9cb37be260177686db9b5681f11ffcb457c07'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'at_spi2_atk'
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
    IO.write('github-desktop.sh', gd)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/github_desktop"
    FileUtils.install 'github-desktop.sh', "#{CREW_DEST_PREFIX}/bin/github-desktop", mode: 0755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/github_desktop"
  end

  def self.postinstall
    puts "\nType 'github-desktop' to get started.\n".lightblue
  end

  def self.remove
    config_dir = "#{CREW_PREFIX}/.config/GitHub\ Desktop"
    if Dir.exist? "#{config_dir}"
      system "echo '#{config_dir}'; ls '#{config_dir}'"
      print "\nWould you like to remove the config directories above? [y/N] "
      case $stdin.getc
      when 'y', 'Y'
        FileUtils.rm_rf config_dir
        puts "'#{config_dir}' removed.".lightred
      else
        puts "'#{config_dir}' saved.".lightgreen
      end
    end
  end
end
