require 'buildsystems/autotools'

class Sysstat < Autotools
  description 'The sysstat utilities are a collection of performance monitoring tools for Linux. These include sar, sadf, mpstat, iostat, tapestat, pidstat, cifsiostat and sa tools.'
  homepage 'https://sysstat.github.io/'
  version '12.7.9'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/sysstat/sysstat.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2bbc4b040c8830a9e1c29c5245aeef718ffeaa0a7a4eba240b3d357e8a4e6743',
     armv7l: '2bbc4b040c8830a9e1c29c5245aeef718ffeaa0a7a4eba240b3d357e8a4e6743',
       i686: '8ce65526577737faa583fa9e837bf755ed8ffa4ae07f7c2ff258f34f175d1945',
     x86_64: '31fda4f33ffb1e7a237e70bb14685e9203b5dbc91652ab9c3afaad5fa373ba0d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.patch
    system "sed -i 's/GRP=root/GRP=$(whoami)/' configure"
    system "sed -i 's/\"root\"/\"$(whoami)\"/g' configure"
    system "sed -i 's/root/$(whoami)/g' configure.ac"
    system "sed -i 's/root/$(whoami)/g' sysstat-#{version}.spec"
  end
end
