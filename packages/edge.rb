require 'package'

class Edge < Package
  description 'Microsoft Edge is the fast and secure browser'
  homepage 'https://www.microsoft.com/en-us/edge'
  @_ver = '103.0.1264.44'
  version @_ver
  compatibility 'x86_64'
  license 'MIT'
  source_url 'https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_103.0.1264.44-1_amd64.deb'
  source_sha256 '5c7bdbd611607eb3df4702e603fd667413d78bbe277a54482af6cedafb02fb2d'

  no_compile_needed

  depends_on 'libcom_err'
  depends_on 'sommelier'

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
    FileUtils.mkdir_p "#{icon_path}"
    FileUtils.mv 'microsoft-edge.png', "#{icon_path}"
  end

  def self.postinstall
    puts "\nType 'edge' to get started.\n".lightblue
  end
end
