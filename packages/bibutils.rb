require 'package'

class Bibutils < Package
  description 'The bibutils program set interconverts between various bibliography formats using a common MODS-format XML intermediate.'
  homepage 'https://sourceforge.net/projects/bibutils/'
  version '7.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/bibutils/bibutils_7.2_src.tgz'
  source_sha256 '6e028aef1e8a6b3e5acef098584a7bb68708f35cfe74011b341c11fea5e4b5c3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c89118226ce77d3e65fa00abad82eef91eefa44368b29f6b8e3848e8e62df0d',
     armv7l: '0c89118226ce77d3e65fa00abad82eef91eefa44368b29f6b8e3848e8e62df0d',
       i686: '84b049d9fe2b18ca4fdda6feb62832e39a8cf64088a33240543ff59590e08744',
     x86_64: '051381447166e48d77e1aee475587f3197dd345f3998c55c80b6914313f6ce4d'
  })

  def self.build
    system "./configure --dynamic --install-dir #{CREW_DEST_PREFIX}/bin --install-lib #{CREW_DEST_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make test'
  end

  def self.install
    system 'make install'
  end
end
