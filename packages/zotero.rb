require 'package'

class Zotero < Package
  description 'Zotero is a free, easy-to-use tool to help you collect, organize, annotate, cite, and share research.'
  homepage 'https://www.zotero.org/'
  version '6.0.35'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.zotero.org/client/release/6.0.35/Zotero-6.0.35_linux-x86_64.tar.bz2'
  source_sha256 '1c054b99a9843ee15fd39e3cfe21177acf9fe179d0ee4535bbd872398855c99d'

  depends_on 'dbus_glib'
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
