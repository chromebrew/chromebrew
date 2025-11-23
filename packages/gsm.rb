require 'package'

class Gsm < Package
  description 'Shared libraries for GSM 06.10 lossy speech compression'
  homepage 'https://www.quut.com/gsm/'
  version '1.0.23'
  license 'gsm'
  compatibility 'all'
  source_url "https://www.quut.com/gsm/gsm-#{version}.tar.gz"
  source_sha256 '8b7591a85ac9adce858f2053005e6b2eb20c23b8b8a868dffb2969645fa323c0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '659c0eb1a7140734d4c6cfbfedae38fd616956901f2d69530a01ff7169adb279',
     armv7l: '659c0eb1a7140734d4c6cfbfedae38fd616956901f2d69530a01ff7169adb279',
       i686: 'e48c6609c640a88d5eccc20dc9c44ebdeba8ff835d1b5bf94739bd5547db0547',
     x86_64: 'bb114f37bbd159fbd29c473891b4f8ac3f8665dc0697a158f1508c02021e96e3'
  })

  depends_on 'glibc' # R

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
