require 'package'

class Libparserutils < Package
  description 'Library for building efficient parsers, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.2.5'
  license 'MIT'
  compatibility 'all'
  source_url "https://download.netsurf-browser.org/libs/releases/libparserutils-#{version}-src.tar.gz"
  source_sha256 '317ed5c718f17927b5721974bae5de32c3fd6d055db131ad31b4312a032ed139'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8efe2831f945ea6d485439cdbd081a595a2450c658beb3dfa1dca04439a7f12',
     armv7l: 'a8efe2831f945ea6d485439cdbd081a595a2450c658beb3dfa1dca04439a7f12',
       i686: 'fdf9a787490a0daacde8d10eedc2c378d6321b1f05a01c9aafe10d4d901489a6',
     x86_64: '37336d94ef206073c83f64f46a1110c92804a158bc1563892be6479f98e29602'
  })

  depends_on 'glibc' # R
  depends_on 'netsurf_buildsystem' => :build

  @env = {
    'PREFIX' => CREW_PREFIX,
    'LIBDIR' => "lib#{CREW_LIB_SUFFIX}",
    'DESTDIR' => CREW_DEST_DIR,
    'COMPONENT_TYPE' => 'lib-shared'
  }

  def self.build
    system @env, 'make'
  end

  def self.install
    system @env, 'make install'
  end
end
