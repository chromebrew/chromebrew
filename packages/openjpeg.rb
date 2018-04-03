require 'package'

class Openjpeg < Package
  description 'OpenJPEG is an open-source JPEG 2000 codec written in C language.'
  homepage 'https://github.com/uclouvain/openjpeg/'
  version '2.3.0'
  source_url 'https://github.com/uclouvain/openjpeg/archive/v2.3.0.tar.gz'
  source_sha256 '3dc787c1bb6023ba846c2a0d9b1f6e179f1cd255172bde9eb75b01f1e6c7d71a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/openjpeg-2.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c02d6f58a4f3fe8c6b200e971e9e4f5864520b9e86eefbce779721bb98b6801d',
     armv7l: 'c02d6f58a4f3fe8c6b200e971e9e4f5864520b9e86eefbce779721bb98b6801d',
       i686: 'ccfce34e8b1fbcdad810c98bced4d84c311f8c1a2c3ab99504e8dfb0661ab791',
     x86_64: 'e76d1c1a50876326b74096733f81a84eff68e979404f9a7ce584a9d040b05bef',
  })

  depends_on 'cmake' => :build

  def self.build
    system "mkdir -p builddir"
    Dir.chdir("builddir") do
      system "cmake",
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             "-DOPENJPEG_INSTALL_LIB_DIR=#{CREW_LIB_PREFIX}",
             "-DCMAKE_BUILD_TYPE=Release",
             ".."
      system "make"
    end
  end

  def self.install
    Dir.chdir("builddir") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
