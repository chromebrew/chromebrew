require 'package'

class Spotify < Package
  description 'Slack is a messaging app for business that connects people to the information they need.'
  homepage 'https://slack.com/'
  @full_ver = '1.2.42.290.g242057a2'
  version @full_ver.partition('.g')[0]
  license 'Proprietary'
  compatibility 'x86_64'
  source_url "http://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_#{@full_ver}_amd64.deb"
  source_sha256 'a379463bcd3e18da7117287facb991c66ed9393dcf24e2e5d8fd17682d1a4f8f'

  # extracted from spotify-client .deb archive
  depends_on 'alsa_lib'  # libasound2
  depends_on 'libxss'    # libxss1
  depends_on 'libxtst'   # libxtst6
  depends_on 'atk'       # libatk-bridge2.0-0
  depends_on 'gcc_dev'   # libatomic1, libstdc++6
  depends_on 'libcurl'   # libcurl3-gnutls
  depends_on 'libgconf'  # libgconf-2-4
  depends_on 'glib'      # libglib2.0
  depends_on 'gtk3'      # libgtk-3-0
  depends_on 'nss'       # libnss3
  depends_on 'xdg_utils' # xdg-utils
  depends_on 'sommelier'

  no_shrink # upx will break chromium/electron-based applications
  no_compile_needed

  def self.install
    prefix         = "#{CREW_DEST_PREFIX}/share/spotify"
    symlink_prefix = prefix.delete_prefix(CREW_DEST_DIR)
    icon_prefix    = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    desktop_prefix = "#{CREW_DEST_PREFIX}/share/applications"
    binpath        = "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/share", binpath, icon_prefix, desktop_prefix]
    FileUtils.cp_r Dir['usr/share/*'], "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{symlink_prefix}/spotify", "#{binpath}/spotify"
    FileUtils.ln_s "#{symlink_prefix}/spotify.desktop", "#{desktop_prefix}/spotify.desktop"

    # handle icons
    %w[16 22 24 32 48 64 128 256 512].each do |size|
      FileUtils.mkdir_p "#{icon_prefix}/#{size}x#{size}/apps"
      FileUtils.install "./usr/share/spotify/icons/spotify-linux-#{size}.png", "#{icon_prefix}/#{size}x#{size}/apps/spotify-client.png"
    end
  end
end
