require 'package'

class Vscode < Package
  description 'Visual Studio Code: Editor for building and debugging modern web and cloud applications'
  homepage 'https://code.visualstudio.com/'
  version '1.91.1'
  license 'Proprietary'
  compatibility 'aarch64,armv7l,x86_64'

  source_url({
    aarch64: 'https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.91.1-1720562810_armhf.deb',
    armv7l:  'https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.91.1-1720562810_armhf.deb',
    x86_64:  'https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.91.1-1720564633_amd64.deb'
  })

  source_sha256({
    aarch64: '0d1d08639b3f04a5ead71a9784fc350f6671fbec35bf93f6df3a2133832832bc',
    armv7l:  '0d1d08639b3f04a5ead71a9784fc350f6671fbec35bf93f6df3a2133832832bc',
    x86_64:  '31a13c05295f3349d3dc168d9c67dda4fcf30823fe3c34f215f0324d197f5479'
  })

  # extracted from code .deb archive
  depends_on 'ca_certificates' # ca-certificates
  depends_on 'alsa_lib'        # libasound2
  depends_on 'atk'             # libatk-bridge2.0-0
  depends_on 'at_spi2_atk'     # libatspi2.0-0
  depends_on 'cairo'           # libcairo2
  depends_on 'libcurl'         # libcurl4
  depends_on 'dbus'            # libdbus-1-3
  depends_on 'pango'           # libpango-1.0-0
  depends_on 'gtk3'            # libgtk-3-0
  depends_on 'nspr'            # libnspr4
  depends_on 'nss'             # libnss3
  depends_on 'gcc_dev'         # libstdc++6
  depends_on 'libsecret'       # libsecret-1-0
  depends_on 'gnome_keyring'   # this fixes login issue
  depends_on 'xdg_utils'       # xdg-utils
  depends_on 'sommelier'       # libx*

  no_shrink # upx will break chromium/electron-based applications
  no_compile_needed

  def self.install
    prefix         = "#{CREW_DEST_PREFIX}/share/code"
    symlink_prefix = prefix.delete_prefix(CREW_DEST_DIR)
    binpath        = "#{CREW_DEST_PREFIX}/bin"

    FileUtils.mkdir_p binpath
    FileUtils.mv 'usr/share/', CREW_DEST_PREFIX
    FileUtils.ln_s "#{symlink_prefix}/code", "#{binpath}/code"
  end
end
