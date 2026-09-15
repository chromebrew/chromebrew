require 'package'

class Gitkraken < Package
  description 'The legendary Git GUI for Windows, Mac and Linux'
  homepage 'https://www.gitkraken.com/git-client'
  version '12.4.1'
  license 'Gitkracken-EULA'
  compatibility 'x86_64'
  source_url 'https://release.gitkraken.dev/gkd/production/normal/linux/x64/12.4.1/3Ijh9hqRbAH7umT5wxyEDUwxraL/gitkraken-amd64.tar.gz'
  source_sha256 '344276052482d68d334fc9535fb681a5600e5658f1a962f04ea09a200fd42ea4'

  depends_on 'alsa_lib' => :executable
  depends_on 'at_spi2_core' => :executable
  depends_on 'bullet' => :executable
  depends_on 'cairo' => :executable
  depends_on 'cjson' => :executable
  depends_on 'cups' => :executable
  depends_on 'curl' => :executable
  depends_on 'dbus' => :executable
  depends_on 'e2fsprogs' => :executable
  depends_on 'eudev' => :executable
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' => :library
  depends_on 'glib' => :executable
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :executable
  depends_on 'krb5' => :executable
  depends_on 'libgit2' => :library
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxcomposite' => :executable
  depends_on 'libxdamage' => :executable
  depends_on 'libxext' => :library
  depends_on 'libxfixes' => :executable
  depends_on 'libxkbcommon' => :executable
  depends_on 'libxkbfile' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'mesa' => :executable
  depends_on 'nss' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pango' => :executable
  depends_on 'sommelier' => :logical
  depends_on 'zlib' => :executable

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv Dir.pwd, "#{CREW_DEST_PREFIX}/share"
    FileUtils.ln_s "#{CREW_PREFIX}/share/gitkraken/gitkraken", "#{CREW_DEST_PREFIX}/bin/gitkraken"
  end
end
