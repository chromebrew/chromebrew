require 'buildsystems/autotools'

class Proxychains < Autotools
  description 'a tool that forces any TCP connection made by any given application to follow through proxy like TOR or any other SOCKS4, SOCKS5 or HTTP(S) proxy.'
  homepage 'https://github.com/haad/proxychains'
  version '4.4.0-2ec9e1d'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/haad/proxychains.git'
  git_hashtag '2ec9e1d7ca7e7d37f8eb67181e2c6580a7fdf3d0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b3bc65b0acc1442f8b42a00fa477bf901647cff4f801337507b74806ffbfeef',
     armv7l: '4b3bc65b0acc1442f8b42a00fa477bf901647cff4f801337507b74806ffbfeef',
       i686: 'c556ab1c23c894e0874eeb90ad358bb09dd4febd793b97f5aed05136acdc127a',
     x86_64: '602ff96d2ccc6736f19e0201ad2e10e4ad7b2f580e84cd1ad45399b53612fb1e'
  })

  depends_on 'drill' => :executable # Needed for proxyresolv.
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library

  def self.patch
    # Fix error: ‘strncpy’ specified bound 256 equals destination size [-Werror=stringop-truncation]
    # See https://github.com/haad/proxychains/pull/178.
    system "sed -i 's/strncpy(data->addr_name, name, sizeof(data->addr_name))/snprintf(data->addr_name, sizeof(data->addr_name), \"%s\", name)/' src/core.c"
    system "sed -i 's/strncpy(space->addr_name, node, sizeof(space->addr_name))/snprintf(space->addr_name, sizeof(space->addr_name), \"%s\", node)/' src/core.c"
  end

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  autotools_install_extras do
    FileUtils.install 'src/proxychains.conf', "#{CREW_DEST_HOME}/.proxychains/proxychains.conf", mode: 0o644
    FileUtils.install 'src/proxychains.conf', "#{CREW_DEST_PREFIX}/etc/proxychains.conf", mode: 0o644
    FileUtils.install 'src/proxyresolv', "#{CREW_DEST_PREFIX}/bin/proxyresolv", mode: 0o755
    # Fix ERROR: ld.so: object 'libproxychains.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/libproxychains.so.4", "#{CREW_DEST_LIB_PREFIX}/libproxychains.so"
  end
end
