require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '30.0'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     armv7l: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     x86_64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-x86_64-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: '68eef66e4c18396449450f45626e023dc96023742bb760aafcf4625a59c01c56',
     armv7l: '68eef66e4c18396449450f45626e023dc96023742bb760aafcf4625a59c01c56',
     x86_64: '00964ae375084113b1162f2f493b9372421608af23539766e315a3cb0ee54248'
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
