require 'package'

class Diffuse < Package
  description 'graphical tool for merging and comparing text files'
  homepage 'http://diffuse.sourceforge.net/'
  version '0.4.8'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/diffuse/diffuse/0.4.8/diffuse-0.4.8.tar.bz2'
  source_sha256 'c1d3b79bba9352fcb9aa4003537d3fece248fb824781c5e21f3fcccafd42df2b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '1d729d31f35e0839c4793d94e08a35088f9fcf8244799aedebdfc554a34cd944',
     armv7l: '1d729d31f35e0839c4793d94e08a35088f9fcf8244799aedebdfc554a34cd944',
     x86_64: '868bd81b7505b4488fdcb86f3b710e45b46e410b4c28c95c73a51411bc73d27f'
  })

  depends_on 'pygtk'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.install
    system 'python', 'install.py',
           "--prefix=#{CREW_PREFIX}",
           "--destdir=#{CREW_DEST_DIR}",
           "--sysconfdir=#{CREW_PREFIX}/etc"
  end
end
