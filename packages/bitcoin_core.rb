require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '31.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     armv7l: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     x86_64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-x86_64-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '66b2b45359efa161031a49898f96aa7cf1455db46ca6102acd16a7197dc3b96f',
     armv7l: '66b2b45359efa161031a49898f96aa7cf1455db46ca6102acd16a7197dc3b96f',
     x86_64: 'b80d9c3e04da78fb6f0569685673418cf686fadba9042d926d13fb87ff503f9e'
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
