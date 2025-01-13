require 'package'

class Discord < Package
  description 'Discord is a proprietary, cross-platform, all-in-one voice and text chat application.'
  homepage 'https://discord.com/'
  version '0.0.61'
  license 'Proprietary'
  compatibility 'x86_64'
  source_url "https://dl.discordapp.net/apps/linux/#{@version}/discord-#{@version}.tar.gz"
  source_sha256 '8c96a9559ebb9ea2d2361b62ecb91fb06355dc9ce09598d0907853c09bcf3bdf'

  # extracted from discord .deb archive
  depends_on 'alsa_lib'    # libasound2
  depends_on 'gcc_dev'     # libatomic1, libstdc++6
  depends_on 'libgconf'    # libgconf-2-4
  depends_on 'libnotify'   # libnotify4
  depends_on 'nspr'        # libnspr4
  depends_on 'nss'         # libnss3
  depends_on 'libxss'      # libxss1
  depends_on 'libxtst'     # libxtst6
  depends_on 'llvm_stage1' # libc++1
  depends_on 'sommelier'

  no_shrink # upx will break chromium/electron-based applications
  no_compile_needed

  def self.install
    prefix         = "#{CREW_DEST_PREFIX}/share/discord"
    symlink_prefix = prefix.delete_prefix(CREW_DEST_DIR)
    icon_prefix    = "#{CREW_DEST_PREFIX}/share/icons/hicolor"
    desktop_prefix = "#{CREW_DEST_PREFIX}/share/applications"
    binpath        = "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mkdir_p [prefix, "#{icon_prefix}/256x256/apps", desktop_prefix, binpath]
    FileUtils.mv Dir['*'], prefix

    FileUtils.ln_s "#{symlink_prefix}/Discord", "#{binpath}/discord"
    FileUtils.ln_s "#{symlink_prefix}/discord.desktop", "#{desktop_prefix}/discord.desktop"
    FileUtils.ln_s "#{symlink_prefix}/discord.png", "#{icon_prefix}/256x256/apps/discord.png"
  end
end
