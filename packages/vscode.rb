require 'package'

class Vscode < Package
  description 'Visual Studio Code: Editor for building and debugging modern web and cloud applications'
  homepage 'https://code.visualstudio.com/'
  version '1.79.1'
  license 'Proprietary'
  compatibility 'aarch64,armv7l,x86_64'

  source_url({
    aarch64: 'https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.79.1-1686587647_armhf.deb',
    armv7l:  'https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.79.1-1686587647_armhf.deb',
    x86_64:  'https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.79.1-1686587647_amd64.deb'
  })

  source_sha256({
    aarch64: 'bad1f3982ce9961f31c4094f695a17a1ef010d4821726bc073eb51a76584f3cf',
    armv7l:  'bad1f3982ce9961f31c4094f695a17a1ef010d4821726bc073eb51a76584f3cf',
    x86_64:  '78e83ba85923600ee982092e83d48f05229b3b4f72de4e706b17a7e30dd8c926'
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

    {
      './usr/share'     => "#{CREW_DEST_PREFIX}/share"
    }.each_pair do |src, dst|
      FileUtils.mkdir_p dst
      FileUtils.cp_r Dir["#{src}/*"], dst
    end

    FileUtils.mkdir_p binpath
    FileUtils.ln_s "#{symlink_prefix}/code", "#{binpath}/code"
  end
end