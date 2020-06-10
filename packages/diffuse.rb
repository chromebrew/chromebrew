require 'package'

class Diffuse < Package
  description 'graphical tool for merging and comparing text files'
  homepage 'http://diffuse.sourceforge.net/'
  version '0.4.8'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/diffuse/diffuse/0.4.8/diffuse-0.4.8.tar.bz2'
  source_sha256 'c1d3b79bba9352fcb9aa4003537d3fece248fb824781c5e21f3fcccafd42df2b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/diffuse-0.4.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/diffuse-0.4.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/diffuse-0.4.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/diffuse-0.4.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d729d31f35e0839c4793d94e08a35088f9fcf8244799aedebdfc554a34cd944',
     armv7l: '1d729d31f35e0839c4793d94e08a35088f9fcf8244799aedebdfc554a34cd944',
       i686: '067c999e0893d4ded1567d22b0f6abcdfa2b4152877d46e676302c211871e7e7',
     x86_64: '868bd81b7505b4488fdcb86f3b710e45b46e410b4c28c95c73a51411bc73d27f',
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
