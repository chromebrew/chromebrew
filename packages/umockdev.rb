require 'package'

class Umockdev < Package
  description 'Mock hardware devices for creating unit tests and bug reporting'
  homepage 'https://github.com/martinpitt/umockdev/'
  version '0.9.4'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/martinpitt/umockdev/archive/0.9.4.tar.gz'
  source_sha256 '9f13e8a836ef36158e2cc2b679cb99639e1f68a430b04fbe4dd07d3cb2b32a75'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '62d6ad9b0cbcbd6c50634e7ee0e77365b810b3a0be57fb61fbde768018428e92',
     armv7l: '62d6ad9b0cbcbd6c50634e7ee0e77365b810b3a0be57fb61fbde768018428e92',
     x86_64: '95fd0e8eeacb4d95051cf80a1d6a44e4882c51f4be477f100c1d69e43f61fbd4'
  })

  depends_on 'glib'
  depends_on 'libgudev'
  depends_on 'vala' => :build
  depends_on 'py3_six' => :build

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
