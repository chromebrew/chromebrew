require 'package'

class Edge < Package
  description 'Microsoft Edge is the fast and secure browser'
  homepage 'https://www.microsoft.com/en-us/edge'
  version '131.0.2903.147-1'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_#{version}_amd64.deb"
  source_sha256 '2a630cc7fa1ec5f39e6aefa983535b25ab8235b02b9e3b021d3e4eedeceec842'

  depends_on 'at_spi2_core'
  depends_on 'libcom_err'
  depends_on 'libxcomposite'
  depends_on 'libxdamage'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.patch
    # Make sure the executable path is correct.
    system "sed -i 's,/usr/bin,#{CREW_PREFIX}/bin,' ./usr/share/applications/microsoft-edge.desktop"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv './usr/share', CREW_DEST_PREFIX
    FileUtils.mv './opt/microsoft/msedge', "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/msedge/msedge", "#{CREW_DEST_PREFIX}/bin/edge"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/msedge/msedge", "#{CREW_DEST_PREFIX}/bin/msedge"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/msedge/msedge", "#{CREW_DEST_PREFIX}/bin/microsoft-edge"
    FileUtils.ln_sf "#{CREW_PREFIX}/share/msedge/msedge", "#{CREW_DEST_PREFIX}/bin/microsoft-edge-stable"
    FileUtils.ln_sf "#{CREW_MAN_PREFIX}/man1/microsoft-edge.1.gz", "#{CREW_DEST_MAN_PREFIX}/man1/edge.1.gz"
    FileUtils.ln_sf "#{CREW_MAN_PREFIX}/man1/microsoft-edge.1.gz", "#{CREW_DEST_MAN_PREFIX}/man1/msedge.1.gz"

    # Add icon for use with crew-launcher
    FileUtils.install "#{CREW_DEST_PREFIX}/share/msedge/product_logo_128.png",
                      "#{CREW_DEST_PREFIX}/share/icons/hicolor/128x128/apps/microsoft-edge.png", mode: 0o644
  end

  def self.postinstall
    print "\nSet Edge as your default browser? [Y/n]: "
    case $stdin.gets.chomp.downcase
    when '', 'y', 'yes'
      Dir.chdir("#{CREW_PREFIX}/bin") do
        FileUtils.ln_sf 'edge', 'x-www-browser'
      end
      puts 'Chrome is now your default browser.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end
    ExitMessage.add "\nType 'edge' to get started.\n"
  end

  def self.preremove
    Dir.chdir("#{CREW_PREFIX}/bin") do
      if File.exist?('x-www-browser') && File.symlink?('x-www-browser') && \
         File.realpath('x-www-browser') == "#{CREW_PREFIX}/share/msedge/msedge"
        FileUtils.rm "#{CREW_PREFIX}/bin/x-www-browser"
      end
    end
  end
end
