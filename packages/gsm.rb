require 'package'

class Gsm < Package
  description 'Shared libraries for GSM 06.10 lossy speech compression'
  homepage 'http://www.quut.com/gsm/'
  version '1.0.19'
  license 'gsm'
  compatibility 'all'
  source_url "http://www.quut.com/gsm/gsm-#{version}.tar.gz"
  source_sha256 '4903652f68a8c04d0041f0d19b1eb713ddcd2aa011c5e595b3b8bca2755270f6'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '4dc9c3426864671b7c61c08d846ff40fd524bf341163997c8e5caddab90c229d',
     armv7l: '4dc9c3426864671b7c61c08d846ff40fd524bf341163997c8e5caddab90c229d',
       i686: 'e5756a9fe38d9dc52bcdfe74dcaee3edc20eb702cd3c8f6e4b7ddd725166d1ad',
     x86_64: '791c1a029c92f1839398617a1b1633e960a21c58ac45b19ad057b0ef0d3ddcfe'
  })

  def self.patch
    # Patch from https://github.com/archlinux/svntogit-packages/blob/master/gsm/trunk/gsm-shared.patch
    system 'curl -Ls https://github.com/archlinux/svntogit-packages/raw/c5a7dd7fe79daea817539ae8315a7cd8eb9cced7/gsm/trunk/gsm-shared.patch | patch -b'
  end

  def self.build
    system "env CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
        make CCFLAGS='-c -fPIC -pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto'"
  end

  def self.install
    # Prepare directories
    @dirs = ['bin', 'lib', 'include/gsm', 'share/gsm', 'share/man/man1', 'share/man/man3']
    @dirs.each do |i|
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/#{i}"
    end
    system "make -j1 INSTALL_ROOT=#{CREW_DEST_PREFIX} \
      GSM_INSTALL_INC=#{CREW_DEST_PREFIX}/include/gsm \
      GSM_INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man3 \
      TOAST_INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man1 \
      install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_PREFIX}/lib64" if ARCH == 'x86_64'
  end
end
