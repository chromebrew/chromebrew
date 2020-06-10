require 'package'

class Libvncserver < Package
  description 'LibVNCServer/LibVNCClient are cross-platform C libraries that allow you to easily implement VNC server or client functionality in your program.'
  homepage 'https://github.com/LibVNC/libvncserver'
  version '0.9.12'
  compatibility 'all'
  source_url 'https://github.com/LibVNC/libvncserver/archive/LibVNCServer-0.9.12.tar.gz'
  source_sha256 '33cbbb4e15bb390f723c311b323cef4a43bcf781984f92d92adda3243a116136'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libvncserver-0.9.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libvncserver-0.9.12-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libvncserver-0.9.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4c2fd37b3d1d6d590a99eb123fb98f8477c8c56a6ff93df9ad438d330a664bb3',
     armv7l: '4c2fd37b3d1d6d590a99eb123fb98f8477c8c56a6ff93df9ad438d330a664bb3',
     x86_64: '958e6ad5cc6414e78e38677d1e5d245ac55c3d55e6648890ec7b5963e97f349a',
  })

  depends_on 'ffmpeg'
  depends_on 'libjpeg_turbo'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DCMAKE_BUILD_TYPE=Release",
             "-DWITH_SYSTEMD=OFF",
             '..'
      system 'cmake --build .'
      system "sed -i 's,${CMAKE_INSTALL_PREFIX}/lib,#{CREW_LIB_PREFIX},g' cmake_install.cmake"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
