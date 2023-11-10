require 'package'

class Musl_cc_toolchain < Package
  description 'A modern, simple, and fast C library implementation that strives to be lightweight, fast, simple, free, and correct in the sense of standards-conformance and safety.'
  homepage 'https://musl.cc/'
  version '1.2.2-b76f37fd'
  compatibility 'aarch64, armv7l, x86_64'
  license 'MIT, LGPL-2 and GPL-2'
  source_url({
    aarch64: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
     armv7l: 'https://musl.cc/armv7l-linux-musleabihf-native.tgz',
     x86_64: 'https://musl.cc/x86_64-linux-musl-native.tgz'
  })
  source_sha256({
    aarch64: '2b37466f716d28a9ef313a8916543f53f9c8c78509e1c8d57a18ca4b171f2205',
     armv7l: '2b37466f716d28a9ef313a8916543f53f9c8c78509e1c8d57a18ca4b171f2205',
     x86_64: 'eb1db6f0f3c2bdbdbfb993d7ef7e2eeef82ac1259f6a6e1757c33a97dbcef3ad'
  })

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cc_toolchain/1.2.2-b76f37fd_armv7l/musl_cc_toolchain-1.2.2-b76f37fd-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cc_toolchain/1.2.2-b76f37fd_armv7l/musl_cc_toolchain-1.2.2-b76f37fd-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/musl_cc_toolchain/1.2.2-b76f37fd_x86_64/musl_cc_toolchain-1.2.2-b76f37fd-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '56b9685504b6ae0894b4c0e9e439c894fc3e9222124982e5c3321279c34de253',
     armv7l: '56b9685504b6ae0894b4c0e9e439c894fc3e9222124982e5c3321279c34de253',
     x86_64: 'ca388d227d187db9b60c53aa191803882a9ac21bcb6c0d1d2815ea2bb8725023'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_MUSL_PREFIX}/lib"
    FileUtils.cp_r '.', "#{CREW_DEST_MUSL_PREFIX}/", verbose: true
    Dir.chdir("#{CREW_DEST_MUSL_PREFIX}/lib") do
      FileUtils.ln_sf 'libc.so', 'ld-musl-x86_64.so.1' if ARCH == 'x86_64'
      FileUtils.ln_sf 'libc.so', 'ld-musl-armhf.so.1' if ARCH == 'armv7l'
    end
    Dir.chdir(CREW_DEST_MUSL_PREFIX) do
      FileUtils.ln_sf 'lib', 'lib64' if ARCH == 'x86_64'
    end
  end

  def self.postinstall; end
end
