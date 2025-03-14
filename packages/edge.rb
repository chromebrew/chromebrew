require 'package'
require 'convenience_functions'

class Edge < Package
  description 'Microsoft Edge is the fast and secure browser'
  homepage 'https://www.microsoft.com/en-us/edge'
  version '134.0.3124.68-1'
  license 'MIT'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_#{version}_amd64.deb"
  source_sha256 'ce337cb2c55e477cb2c3e7bab55cdcaeb6242d3a28f119a6e068dc1bd8903299'

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
    ConvenienceFunctions.set_default_browser('Edge', 'msedge')
  end

  def self.preremove
    ConvenienceFunctions.unset_default_browser('msedge', 'msedge')
  end
end
