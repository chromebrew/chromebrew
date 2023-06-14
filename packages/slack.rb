require 'package'

class Slack < Package
  description 'Slack is a messaging app for business that connects people to the information they need.'
  homepage 'https://slack.com/'
  version '4.32.127'
  license 'Proprietary'
  compatibility 'x86_64'
  source_url 'https://downloads.slack-edge.com/releases/linux/4.32.127/prod/x64/slack-desktop-4.32.127-amd64.deb'
  source_sha256 '8e0216aba77798b6252902a0bd6fe2286325fdf246916f5ed4cabed3e7527521'

  # extracted from slack-desktop .deb archive
  depends_on 'alsa_lib'             # libasound2
  depends_on 'gtk3'                 # libgtk-3-0
  depends_on 'libappindicator_gtk3' # libappindicator3-1
  depends_on 'libnotify'            # libnotify4
  depends_on 'nspr'                 # libnspr4
  depends_on 'nss'                  # libnss3
  depends_on 'libxss'               # libxss1
  depends_on 'libxtst'              # libxtst6
  depends_on 'xdg_utils'            # xdg-utils
  depends_on 'at_spi2_atk'          # libatspi2.0-0
  depends_on 'libuuid'              # libuuid1
  depends_on 'glib'                 # libglib2.0-bin
  depends_on 'sommelier'

  no_compile_needed

  def self.install
    prefix         = "#{CREW_DEST_PREFIX}/share/slack"
    symlink_prefix = prefix.delete_prefix(CREW_DEST_DIR)
    binpath        = "#{CREW_DEST_PREFIX}/bin"

    {
      './usr/share'     => "#{CREW_DEST_PREFIX}/share",
      './usr/lib/slack' => prefix
    }.each_pair do |src, dst|
      FileUtils.mkdir_p dst
      FileUtils.cp_r Dir["#{src}/*"], dst
    end

    FileUtils.mkdir_p binpath
    FileUtils.ln_s "#{symlink_prefix}/slack", "#{binpath}/slack"
  end
end