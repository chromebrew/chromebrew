require 'package'

class M4 < Package
  description 'GNU M4 is an implementation of the traditional Unix macro processor.'
  homepage 'https://www.gnu.org/software/m4/'
  version '1.4.19'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gnu/m4/m4-1.4.19.tar.xz'
  source_sha256 '63aede5c6d33b6d9b13511cd0be2cac046f2e70fd0a07aa9573a04a82783af96'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/m4/1.4.19_armv7l/m4-1.4.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/m4/1.4.19_armv7l/m4-1.4.19-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/m4/1.4.19_i686/m4-1.4.19-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/m4/1.4.19_x86_64/m4-1.4.19-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5ebe54bc2df20f9ce90e3d7974f82092ae7600b1ce61bf87c7f414a1447c2a25',
     armv7l: '5ebe54bc2df20f9ce90e3d7974f82092ae7600b1ce61bf87c7f414a1447c2a25',
       i686: 'f339b5b35d5a7d507ad4502bed7f1a88be4582f8aef7ef05145a59d7297e7aa8',
     x86_64: '6a5c76203b00d2058e27e4a65aafb737b30bf1d2225fa6be0c30738d19a1e782'
  })

  depends_on 'glibc' # R
  depends_on 'libsigsegv'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
