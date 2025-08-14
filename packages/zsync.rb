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
    aarch64: 'ec99187285ee26098f60a08e075e61fe7ea2b66b153052c3be9aac8866c39d77',
     armv7l: 'ec99187285ee26098f60a08e075e61fe7ea2b66b153052c3be9aac8866c39d77',
       i686: 'fd3630d2edcdac1730de54d82674505a1b98c2430e3fb04224147348175bbc69',
     x86_64: 'ce5a3c89fec4f13638ade49db7c2c45ca169e86b34687b3c55710f534789aba6'
  })

  depends_on 'glibc' # R

  def self.patch
    downloader 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD', 'asasasa', 'autotools/config.guess'
    downloader 'https://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD', 'asascdcd', 'autotools/config.sub'
  end
end
