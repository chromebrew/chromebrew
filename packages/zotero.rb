require 'package'

class Zotero < Package
  description 'Zotero is a free, easy-to-use tool to help you collect, organize, annotate, cite, and share research.'
  homepage 'https://www.zotero.org/'
  version '6.0.30'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.zotero.org/client/release/6.0.30/Zotero-6.0.30_linux-x86_64.tar.bz2'
  source_sha256 'e17419d71c3d42d9374b31ccb04524f87b8862d1c300e320a70cdb01de504295'

  depends_on 'gtk3'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/zotero"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/zotero"
    FileUtils.ln_s "#{CREW_PREFIX}/share/zotero/zotero", "#{CREW_DEST_PREFIX}/bin/zotero"
  end

  def self.postinstall
    puts "\nType 'zotero' to get started.\n".lightblue
  end
end
