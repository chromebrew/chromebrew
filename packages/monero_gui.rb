require 'package'
require 'misc_functions'

class Monero_gui < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.4.5'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'x86_64'
  source_url "https://downloads.getmonero.org/gui/monero-gui-linux-x64-v#{version}.tar.bz2"
  source_sha256 '6200d97615f23a3701c2cc51da3e9472ccd71561c259ca62f60030ef40ce785c'

  depends_on 'monero' # R
  depends_on 'xcb_util' # R
  depends_on 'xcb_util_image' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'xcb_util_renderutil' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.preflight
    MiscFunctions.check_free_disk_space(425302426)
  end

  def self.build
    File.write 'monero.sh', <<~EOF
      #!/bin/bash
      GDK_BACKEND=x11 #{CREW_PREFIX}/bin/monero-wallet-gui "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/monero"
    FileUtils.mv 'monero-wallet-gui', "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'monero.sh', "#{CREW_DEST_PREFIX}/bin/monero", mode: 0o755
    FileUtils.mv 'monero-gui-wallet-guide.pdf', "#{CREW_DEST_PREFIX}/share/monero"
  end

  def self.postinstall
    ExitMessage.add <<~EOF

      Type 'monero' to get started.
      To view the user guide, execute the following:
      crew install zathura && zathura #{CREW_PREFIX}/share/monero/monero-gui-wallet-guide.pdf
    EOF
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.bitmonero")
  end
end
