require 'package'

class Musl_cc_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version '1.2.2-b76f37fd-1'
  compatibility 'aarch64 armv7l x86_64'
  license 'MIT, LGPL-2 and GPL-2'
  source_url({
    aarch64: 'https://musl.cc/aarch64-linux-musl-native.tgz',
     armv7l: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
     x86_64: 'https://musl.cc/x86_64-linux-musl-native.tgz'
  })
  source_sha256({
    aarch64: 'daf336cafa2c3c7daf42f6a46edc960f10a181fcf15ab9f1c43b192e8ad2a069',
     armv7l: '2b37466f716d28a9ef313a8916543f53f9c8c78509e1c8d57a18ca4b171f2205',
     x86_64: 'eb1db6f0f3c2bdbdbfb993d7ef7e2eeef82ac1259f6a6e1757c33a97dbcef3ad'
  })
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a12693a561da1ec77fac3d8b22bd3429a6ed5116925e16c8c5a3eb7a937a49f0',
     armv7l: '6ee57de663beb86ddf376cf72f02550b97175f20853d85f16ed80557e3547f7b',
     x86_64: 'b306b0277e28a095107fb105059ad60b1ee84fca31028a2aa00535730f846362'
  })

  print_source_bashrc

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_MUSL_PREFIX}/lib"
    FileUtils.cp_r '.', "#{CREW_DEST_MUSL_PREFIX}/", verbose: true
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/lib") do
      FileUtils.ln_sf 'libc.so', 'ld-musl-aarch64.so.1' if ARCH == 'aarch64'
      FileUtils.ln_sf 'libc.so', 'ld-musl-x86_64.so.1' if ARCH == 'x86_64'
      FileUtils.ln_sf 'libc.so', 'ld-musl-armhf.so.1' if ARCH == 'armv7l'
    end
    Dir.chdir(CREW_DEST_MUSL_PREFIX) do
      FileUtils.ln_sf 'lib', 'lib64' if %w[aarch64 x86_64].include?(ARCH)
    end
  end
end
