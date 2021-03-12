require 'package'

class Intel_media_sdk < Package
  description 'API to access hardware-accelerated video on Intel Gen graphics hardware platforms'
  homepage 'https://software.intel.com/en-us/media-sdk/'
  version '20.5.1'
  compatibility 'x86_64'
  if ARCH == 'x86_64'
    source_url 'https://github.com/Intel-Media-SDK/MediaSDK/archive/intel-mediasdk-20.5.1.tar.gz'
    source_sha256 '047986646f185313df2159fd44bccd870e173bb1cae9c2501ac6b9774bfd424b'
    depends_on 'intel_media_driver'
    depends_on 'libdrm'
    depends_on 'libva'
    depends_on 'wayland'
  end

  binary_url({
    x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/intel_media_sdk-20.5.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    x86_64: '89aac36a221473846222f7550109055c674927aff2273fd1e1f807d046c8046b'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DBUILD_SHARED_LIBS=ON \
        -DBUILD_ALL:BOOL='ON' \
        -DBUILD_TOOLS:BOOL='ON' \
        -DENABLE_ITT:BOOL='OFF' \
        -DENABLE_OPENCL:BOOL='ON' \
        -DENABLE_WAYLAND:BOOL='ON' \
        -DENABLE_X11_DRI3:BOOL='ON' \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
