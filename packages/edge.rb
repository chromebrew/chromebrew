require 'package'

class Edge < Package
  description 'Microsoft Edge is the fast and secure browser'
  homepage 'https://www.microsoft.com/en-us/edge'
  version '114.0.1823.55-1'
  compatibility 'x86_64'
  license 'MIT'
  source_url 'https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_114.0.1823.55-1_amd64.deb'
  source_sha256 '9828539f8220ee98dba5752ddbc08ecdaa595d4354bd08ff1abd9d4c837b67b2'

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
    downloader 'https://cdn.icon-icons.com/icons2/2552/PNG/128/edge_browser_logo_icon_152998.png',
               'ae7b1378a5d9d84314b459b6a16c3ec14aae0b88eeb78040f7bc28156cf2d753', 'microsoft-edge.png'

    icon_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor/128x128/apps"
    FileUtils.mkdir_p icon_path.to_s
    FileUtils.mv 'microsoft-edge.png', icon_path.to_s
  end

  def self.postinstall
    puts "\nType 'edge' to get started.\n".lightblue
  end
end
