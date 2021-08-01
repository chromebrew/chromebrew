require 'package'

class Libfilezilla < Package
  description 'libfilezilla is a small and modern C++ library, offering some basic functionality to build high-performing, platform-independent programs.'
  homepage 'https://lib.filezilla-project.org/'
  version '0.30.0'
  license 'GPL-2+'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://download.filezilla-project.org/libfilezilla/libfilezilla-0.30.0.tar.bz2'
  source_sha256 'c16df6dacdb2ded4f6e05141b4681eda91a5a1ba052900a24a9f84e65a50dc40'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.30.0_armv7l/libfilezilla-0.30.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.30.0_armv7l/libfilezilla-0.30.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfilezilla/0.30.0_x86_64/libfilezilla-0.30.0-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '377a1c8a97c728d5b920099ef9dfc45e5d28fa66d937cf67c756a8876f9f32df',
     armv7l: '377a1c8a97c728d5b920099ef9dfc45e5d28fa66d937cf67c756a8876f9f32df',
     x86_64: '7fe37df89a8d984beb1b875c03f6cd51efec0003472dc9fcdfdec9d5a35d488f',
  })

  depends_on 'p11kit'

  def self.patch
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
