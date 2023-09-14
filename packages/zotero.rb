require 'package'

class Zotero < Package
  description 'Zotero is a free, easy-to-use tool to help you collect, organize, annotate, cite, and share research.'
  homepage 'https://www.zotero.org/'
  version '6.0.27'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.zotero.org/client/release/6.0.27/Zotero-6.0.27_linux-x86_64.tar.bz2'
  source_sha256 'fa708f2d5541904bb48362b1b7f5d802deac631626d399cf7263cd4b639e8d1b'

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
