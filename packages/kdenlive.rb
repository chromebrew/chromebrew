require 'package'

class Kdenlive < Package
  description 'Free and Open Source KDE Non-Linear Video Editor'
  homepage 'https://kdenlive.org/'
  version '26.04.3'
  license 'GPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://download.kde.org/stable/kdenlive/#{version.split('.')[0..1].join('.')}/linux/kdenlive-#{version}-x86_64.AppImage"
  source_sha256 '5f282f5f49bfe5b0d7a7298e8f2e9061f212ee4d3b8103508cd05f8e397b03d4'

  depends_on 'gtk3' => :executable
  depends_on 'gdk_base' => :logical
  depends_on 'libxss' => :library
  depends_on 'libxtst' => :library
  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.build
    File.write 'kdenlive.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/kdenlive
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/kdenlive"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'kdenlive.sh', "#{CREW_DEST_PREFIX}/bin/kdenlive", mode: 0o755
    FileUtils.mv 'org.kde.kdenlive.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv Dir['AppRun*'], "#{CREW_DEST_PREFIX}/share/kdenlive"
    FileUtils.mv 'apprun-hooks', "#{CREW_DEST_PREFIX}/share/kdenlive"
    FileUtils.mv 'usr/share/icons', "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv 'usr', "#{CREW_DEST_PREFIX}/share/kdenlive"
  end

  def self.postinstall
    ExitMessage.add "\nType 'kdenlive' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.cache/kdenlive")
    Package.agree_to_remove("#{HOME}/.config/kdenlive*")
  end
end
