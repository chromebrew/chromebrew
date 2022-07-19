require 'package'

class Libfmt < Package
  description 'A modern formatting library'
  homepage 'https://fmt.dev'
  version '8.1.1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/fmtlib/fmt/releases/download/8.1.1/fmt-8.1.1.zip'
  source_sha256 '23778bad8edba12d76e4075da06db591f3b0e3c6c04928ced4a7282ca3400e5d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/8.1.1_armv7l/libfmt-8.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/8.1.1_armv7l/libfmt-8.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/8.1.1_i686/libfmt-8.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libfmt/8.1.1_x86_64/libfmt-8.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a1580b9b29d179ac82030a7590d53fc12e986c355a650bf2f11481ca7948971e',
     armv7l: 'a1580b9b29d179ac82030a7590d53fc12e986c355a650bf2f11481ca7948971e',
       i686: 'e2f30b8f2a2de5f62fbc4d7f1289cd1740f1738c357d0aaee298f146566510e4',
     x86_64: '7ad502f9ffe1781f22ccaf4fdef738de743568e8017cf38fbec8fbcf6a2c4043'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake #{CREW_CMAKE_OPTIONS} \
              -DBUILD_SHARED_LIBS=TRUE \
              .."
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end

  def self.check
    Dir.chdir 'builddir' do
      system 'make', 'test'
    end
  end
end
