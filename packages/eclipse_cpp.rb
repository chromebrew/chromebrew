# Adapted from Arch Linux AUR eclipse-cpp PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=eclipse-cpp
require 'package'

class Eclipse_cpp < Package
  description 'Highly extensible IDE (C/C++ version)'
  homepage 'https://www.eclipse.org/'
  version '4.27'
  license 'EPL'
  compatibility 'x86_64'
  source_url 'https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2023-03/R/eclipse-cpp-2023-03-R-linux-gtk-x86_64.tar.gz&r=1'
  source_sha256 '3019e0dc44daac73255143e956f30867156aa5ef495b9c4d1e89e737a08745cc'

  depends_on 'openjdk11'
  depends_on 'webkit2gtk'
  depends_on 'unzip'
  depends_on 'sommelier'

  no_compile_needed

  def self.preflight
    conflicts = %w[eclipse_java eclipse_php]

    if conflicts.any? {|pkg| File.exist?("#{CREW_META_PATH}/#{pkg}.filelist") }
      abort "Please remove #{pkg} first before installing.".lightred
    end
  end

  def self.build
    File.write 'eclipse.desktop', <<~EOF
      [Desktop Entry]
      Name=Eclipse
      Comment=Java Development Environment
      Icon=eclipse
      Exec=eclipse
      Terminal=false
      Type=Application
      Categories=Development;IDE;Java;
      StartupNotify=true
    EOF
  end

  def self.install
    prefix         = "#{CREW_DEST_PREFIX}/share/eclipse"
    symlink_prefix = prefix.delete_prefix(CREW_DEST_DIR)
    icon_prefix    = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    desktop_prefix = "#{CREW_DEST_PREFIX}/share/applications"
    binpath        = "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mkdir_p [prefix, icon_prefix, desktop_prefix, binpath]
    FileUtils.cp_r Dir['usr/lib/eclipse/*'], prefix

    FileUtils.ln_s "#{symlink_prefix}/eclipse", "#{binpath}/eclipse"
    FileUtils.ln_s "#{symlink_prefix}/eclipse.desktop", "#{desktop_prefix}/eclipse.desktop"

    # handle icons
    %w[16 22 24 32 48 64 128 256 512 1024].each do |size|
      FileUtils.mkdir_p "#{icon_prefix}/#{size}x#{size}/apps"
      FileUtils.cp Dir["plugins/org.eclipse.platform_#{version}*/eclipse#{size}.png"], "#{icon_prefix}/#{size}x#{size}/apps/eclipse.png"
    end
  end
end