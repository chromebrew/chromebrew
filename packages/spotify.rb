require 'package'

class Spotify < Package
  description 'Slack is a messaging app for business that connects people to the information they need.'
  homepage 'https://slack.com/'
  version '1.2.11.916'
  license 'Proprietary'
  compatibility 'x86_64'
  source_url 'http://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.2.11.916.geb595a67_amd64.deb'
  source_sha256 '472bf841451c219320f1ca038915f52bd4afdf7a1c979571d6ed541ca5e26d51'

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

  no_compile_needed

  def self.install
    prefix         = "#{CREW_DEST_PREFIX}/share/spotify"
    symlink_prefix = prefix.delete_prefix(CREW_DEST_DIR)
    icon_prefix    = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    desktop_prefix = "#{CREW_DEST_PREFIX}/share/applications"
    binpath        = "#{CREW_DEST_PREFIX}/bin"

    {
      './usr/share'     => "#{CREW_DEST_PREFIX}/share"
    }.each_pair do |src, dst|
      FileUtils.mkdir_p dst
      FileUtils.cp_r Dir["#{src}/*"], dst
    end

    FileUtils.mkdir_p [binpath, icon_prefix, desktop_prefix]
    FileUtils.ln_s "#{symlink_prefix}/spotify", "#{binpath}/spotify"
    FileUtils.ln_s "#{symlink_prefix}/spotify.desktop", "#{desktop_prefix}/spotify.desktop"

    # handle icons
    %w[16 22 24 32 48 64 128 256 512].each do |size|
      FileUtils.mkdir_p "#{icon_prefix}/#{size}x#{size}/apps"
      FileUtils.cp "./usr/share/spotify/icons/spotify-linux-#{size}.png", "#{icon_prefix}/#{size}x#{size}/apps/spotify-client.png"
    end
  end
end