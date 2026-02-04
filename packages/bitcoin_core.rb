require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '30.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     armv7l: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     x86_64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-x86_64-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'd510542842318ea34d87cb2c93d6a7fe091dcac2e8684460be2b3c44843fb502',
     armv7l: 'd510542842318ea34d87cb2c93d6a7fe091dcac2e8684460be2b3c44843fb502',
     x86_64: '6aa7bb4feb699c4c6262dd23e4004191f6df7f373b5d5978b5bcdd4bb72f75d8'
  })

  # Dependencies needed for bitcoin-qt
  depends_on 'fontconfig'
  depends_on 'libxkbcommon'
  depends_on 'xcb_util'
  depends_on 'xcb_util_image'
  depends_on 'xcb_util_keysyms'
  depends_on 'xcb_util_renderutil'
  depends_on 'xcb_util_wm'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mv 'bin/', CREW_DEST_PREFIX
    FileUtils.mv 'share/', CREW_DEST_PREFIX
    FileUtils.mv 'bitcoin.conf', "#{CREW_DEST_PREFIX}/etc"
  end

  def self.postremove
    if Dir.exist? "#{HOME}/.bitcoin"
      puts 'WARNING: This will remove all bitcoin data including wallets!'.orange
      Package.agree_to_remove("#{HOME}/.bitcoin")
    end
  end
end
