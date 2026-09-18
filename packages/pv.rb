require 'buildsystems/autotools'

class Pv < Autotools
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.12.0'
  license 'Artistic-2'
  compatibility 'all'
  source_url "https://www.ivarch.com/programs/sources/pv-#{version}.tar.gz"
  source_sha256 '31fdbdb449c7143cd2968567bef7599e9f031950e6158ee7bb76e40aebf6ffb8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8cb92435dcb75d28b3d4a8ed486df1798d9020beb7ef73fdcd762463fc9b38d3',
     armv7l: '8cb92435dcb75d28b3d4a8ed486df1798d9020beb7ef73fdcd762463fc9b38d3',
       i686: 'db192b2ae12f8aaf60b6bbb48db9d31dccbc7731883b40118479fa4fdf613b7a',
     x86_64: '103acfbe4386cb740f2b91ad56596f481cb9acfa2673cf5a025d63bfd63686ce'
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
