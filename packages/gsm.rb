require 'package'

class Gsm < Package
  description 'Shared libraries for GSM 06.10 lossy speech compression'
  homepage 'https://www.quut.com/gsm/'
  version '1.0.24'
  license 'gsm'
  compatibility 'all'
  source_url "https://www.quut.com/gsm/gsm-#{version}.tar.gz"
  source_sha256 'a3c40c6471928383f4abfcb2e8f24012a1f562be2f17b8d672145d5986681a92'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a692a3c60d8d84d3b7057180a826335df9e1a7e35662361e69954e50ecde2866',
     armv7l: 'a692a3c60d8d84d3b7057180a826335df9e1a7e35662361e69954e50ecde2866',
       i686: '518f2c55d8c5f7a2485cbff3c4929f28ce390cdbbc1d964b2f4fc69b4f6f6f55',
     x86_64: '8031da6c2168e2d3f54b43b413c700d82f7d03158a4d6cc5cc3af4505dd829c0'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

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
