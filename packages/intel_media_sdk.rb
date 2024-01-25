require 'package'

class Intel_media_sdk < Package
  description 'API to access hardware-accelerated video on Intel Gen graphics hardware platforms'
  homepage 'https://software.intel.com/en-us/media-sdk/'
  version '20.5.1'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/Intel-Media-SDK/MediaSDK/archive/intel-mediasdk-20.5.1.tar.gz'
  source_sha256 '047986646f185313df2159fd44bccd870e173bb1cae9c2501ac6b9774bfd424b'
  binary_compression 'tar.xz'

  depends_on 'intel_media_driver'
  depends_on 'libdrm'
  depends_on 'libva'
  depends_on 'wayland'

  binary_sha256({
    x86_64: '6c50fda47c7711dbc506badef677cb9f9941ffd5fc0d147562117f08da7658f2'
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
