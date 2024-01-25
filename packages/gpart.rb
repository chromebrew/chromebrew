require 'package'

class Gpart < Package
  description 'Partition table rescue/guessing tool.'
  homepage 'https://github.com/baruch/gpart'
  version '0.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/baruch/gpart/archive/0.3.tar.gz'
  source_sha256 'ec56d12ec9ffdb9877c12692ea6e51620b1ae44473d3d253b27fc31ed9ebb4dd'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '9dc4ad8e5e2d1784658424a6e42bae45d1703995181e925afcd0733623cc05ab',
     armv7l: '9dc4ad8e5e2d1784658424a6e42bae45d1703995181e925afcd0733623cc05ab',
       i686: '599cace7c0cac373c09925ae611961c87aba2812ce7dfa799e1257153fc07f5c',
     x86_64: '357672cb2abb1ea3ecfe07c0ed586625e111591500ec031964c81f9b78bacbd6'
  })

  def self.build
    system 'sh autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install' # the steps required to install the package
  end
end
