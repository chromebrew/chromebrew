require 'package'

class Bitcoin_core < Package
  description 'Bitcoin Core is a full Bitcoin client and builds the backbone of the network.'
  homepage 'https://bitcoincore.org/'
  version '29.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  min_glibc '2.29'
  source_url({
    aarch64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     armv7l: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-arm-linux-gnueabihf.tar.gz",
     x86_64: "https://bitcoincore.org/bin/bitcoin-core-#{version}/bitcoin-#{version}-x86_64-linux-gnu.tar.gz"
  })
  source_sha256({
    aarch64: 'aec1838105c44a97e10bd7a47af52d83728c98272f9e32650b3fe83ed78f9dec',
     armv7l: 'aec1838105c44a97e10bd7a47af52d83728c98272f9e32650b3fe83ed78f9dec',
     x86_64: '2dddeaa8c0626ec446b6f21b64c0f3565a1e7e67ff0b586d25043cbd686c9455'
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
