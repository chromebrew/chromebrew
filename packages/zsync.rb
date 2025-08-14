require 'buildsystems/autotools'

class Zsync < Autotools
  description 'zsync is a client-side file transfer program similar to rsync.'
  homepage 'http://zsync.moria.org.uk/'
  version '0.6.3'
  license 'Artistic-2'
  compatibility 'all'
  source_url "https://zsync.moria.org.uk/download/zsync-#{version}.tar.bz2"
  source_sha256 '0b9d53433387aa4f04634a6c63a5efa8203070f2298af72a705f9be3dda65af2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7e83459da35ae6c1ae2522f5303da8eb7d8efb54d95dfefc13eb997efdbb593',
     armv7l: 'f7e83459da35ae6c1ae2522f5303da8eb7d8efb54d95dfefc13eb997efdbb593',
       i686: 'dd72efc81d19983e828cedb61a0313d50b67e51a90a8fabbf019768c9ba2b856',
     x86_64: 'c2fec91043612cbf99514003f273f2334596cfc7c41f8746e415cc88ae0f0099'
  })

  depends_on 'glibc' # R

  def self.patch
    downloader 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD', 'asasasa', 'autotools/config.guess'
    downloader 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD', 'asascdcd', 'autotools/config.sub'
  end
end
