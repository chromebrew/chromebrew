require 'package'

class Monero_gui < Package
  description 'Private, decentralized cryptocurrency that keeps your finances confidential and secure.'
  homepage 'https://www.getmonero.org/'
  version '0.18.3.3'
  license 'The Cryptonote developers,The Boolberry developers,MIT'
  compatibility 'x86_64'
  source_url "https://downloads.getmonero.org/gui/monero-gui-linux-x64-v#{version}.tar.bz2"
  source_sha256 '893c3986583814b048f1109ba1047c8fe2bbe5ecd7687fe767c1b70ec2571e52'

  depends_on 'monero'
  depends_on 'xcb_util_image'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_wm'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

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
end
