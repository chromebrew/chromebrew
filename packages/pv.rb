require 'buildsystems/autotools'

class Pv < Autotools
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.12.7'
  license 'Artistic-2'
  compatibility 'all'
  source_url "https://www.ivarch.com/programs/sources/pv-#{version}.tar.gz"
  source_sha256 '5326ed7ee95ef18039390c0b17891ac28985ac7c7a4235070fab767c1fe37bd8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4264d6651f747aca4971099030bfee4cf4b5f750ae46db847a0f280e1b53bf4',
     armv7l: 'd4264d6651f747aca4971099030bfee4cf4b5f750ae46db847a0f280e1b53bf4',
       i686: '30747e5438823bd4d0b4805b6839ac50fd541a77d5d4b07b822ce3f1f0682a3e',
     x86_64: 'd3fc5992e4ac52c77d57b0dd290b70852547f99cd670ba359224d5588015a71a'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  def self.build
    system 'autoreconf -fiv'
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end
end
