require 'buildsystems/autotools'

class Pv < Autotools
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.11.0'
  license 'Artistic-2'
  compatibility 'all'
  source_url "https://www.ivarch.com/programs/sources/pv-#{version}.tar.gz"
  source_sha256 'fc02c9fc2b82b20a92cc8d98f844be63f22abd98751a8e4abc875e1d803662eb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c14f0e41f98b4803071b04eeb1098ccbff37a8973361351ac71e051ec27ef25',
     armv7l: '7c14f0e41f98b4803071b04eeb1098ccbff37a8973361351ac71e051ec27ef25',
       i686: '3db1bdebd24d6923c1cc9c46621fc4de3f7364f3158586e71ddf519a3e119a3d',
     x86_64: 'da0a8238e701e292b084a057583df1eb527793cbd25f063578379c8b08864851'
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
