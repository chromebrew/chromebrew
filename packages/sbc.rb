require 'buildsystems/autotools'

class Sbc < Autotools
  description 'SBC is a digital audio encoder and decoder used to transfer data to Bluetooth audio output devices.'
  homepage 'https://www.linuxfromscratch.org/blfs/view/svn/multimedia/sbc.html'
  version '2.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/linux/bluetooth/sbc-#{version}.tar.xz"
  source_sha256 'a1ada76ef35e5af9c2fbd063754dc9e37a8d989417c6eb1ecebb089b1383ae9e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57287efd1e700d01de2cdf1864df60770e141b8e34f35b99f50098c9e69e521c',
     armv7l: '57287efd1e700d01de2cdf1864df60770e141b8e34f35b99f50098c9e69e521c',
       i686: '712f5585af3360d502207aa806fd43da99f5ebfb09785c3349b2fcef97972402',
     x86_64: '7fe4781bac996f63a148cec3fbc864dd6e0592f9e1d68f7d627f815133c68649'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libsndfile' => :build

  autotools_configure_options '--enable-high-precision \
          --disable-static \
          --enable-pie'
end
