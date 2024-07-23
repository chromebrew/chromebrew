require 'package'

class Pv < Package
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.6.6'
  license 'Artistic-2'
  compatibility 'all'
  source_url 'http://www.ivarch.com/programs/sources/pv-1.6.6.tar.gz'
  source_sha256 '94defb4183ae07c44219ba298d43c4991d6e203c29f74393d72ecad3b090508a'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'da5302deb6b9d72962e10ace08c96a5c76a4b48186f58333c1413e2526231157',
     armv7l: 'da5302deb6b9d72962e10ace08c96a5c76a4b48186f58333c1413e2526231157',
       i686: 'a740e89e34a69a7fef3c4d9a3fbd74b7d714dc314ede00c00da6a425015931f9',
     x86_64: 'b248c250d1c87c4e7c1c82ca1918eb4a44ca93585128a58caea074d44e7b4187'
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
