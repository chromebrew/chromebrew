require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.10.0'
  compatibility 'all'
  source_url 'https://github.com/intel/libva/releases/download/2.10.0/libva-2.10.0.tar.bz2'
  source_sha256 'fa81e35b50d9818fce5ec9eeeeff08a24a8864ceeb9a5c8e7ae4446eacfc0236'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libva-2.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '5f66aaac102c5c21759a5f4e7395a79b94292f3aa653d970ce0460fdfa2cbfa6',
      armv7l: '5f66aaac102c5c21759a5f4e7395a79b94292f3aa653d970ce0460fdfa2cbfa6',
        i686: '0511fbc6c345dbf98d46638a20e8ed53341fc9dbe415792217181d535e9819f0',
      x86_64: '500ce66bbf4884373920cc09cc5eea80e6d4864c274b8f93e9bc4ffe2394263a',
  })

  depends_on 'llvm'  => ':build'
  depends_on 'libdrm'

  def self.build
    ENV['CXXFLAGS'] = "-fuse-ld=lld"
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
