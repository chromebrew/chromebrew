require 'package'

class Foxit_reader < Package
  description "Industry's most powerful PDF reader. View, annotate, form fill, and sign PDFs."
  homepage 'https://www.foxit.com/pdf-reader/'
  version '2.4.4.0911'
  license 'Foxit'
  compatibility 'x86_64'
  source_url 'SKIP'

  no_compile_needed

  depends_on 'sommelier'

  def self.install
    foxit_bin = "#{HOME}/Downloads/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz"
    foxit_sha256 = '6b579bd4ecdf86f7e70a009886c511da0b5085b831b0d6afc42442cabc249b90'
    platform = 'Linux-64-bit'
    unless File.exist? foxit_bin
      puts "\nCopy and paste into your browser address bar the url below and download to #{HOME}/Downloads.".orange
      puts "\nhttps://www.foxit.com/downloads/latest.html?product=Foxit-Reader&platform=#{platform}&version=&package_type=&language=English&distID=".orange
      puts "\nAfter the download is complete, restart and install to #{CREW_DEST_PREFIX}/share/foxitreader.\n".orange
      abort
    end
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read(foxit_bin)) == foxit_sha256
    system "tar xvf #{foxit_bin}"
    system "./'FoxitReader.enu.setup.2.4.4.0911(r057d814).x64.run'"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/share/foxitreader/FoxitReader", "#{CREW_DEST_PREFIX}/bin/foxit"
    FileUtils.ln_s "#{CREW_PREFIX}/share/foxitreader/FoxitReader", "#{CREW_DEST_PREFIX}/bin/foxitreader"
    FileUtils.ln_s "#{CREW_PREFIX}/share/foxitreader/FoxitReader", "#{CREW_DEST_PREFIX}/bin/FoxitReader"

    # Prepare FoxitReader.desktop and FoxitReader.ico for use with crew-launcher.
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/foxitreader/Activation.desktop"
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/foxitreader/Uninstall.desktop"
    FileUtils.rm "#{CREW_DEST_PREFIX}/share/foxitreader/Update.desktop"
    system "sed -i 's,#{CREW_DEST_PREFIX}/share/foxitreader/FoxitReader.sh,#{CREW_PREFIX}/share/foxitreader/FoxitReader,' #{CREW_DEST_PREFIX}/share/foxitreader/FoxitReader.desktop"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    icon_path = "#{CREW_DEST_PREFIX}/share/icons/hicolor/64x64/apps"
    FileUtils.mkdir_p icon_path.to_s
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/foxitreader/FoxitReader.desktop", "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv "#{CREW_DEST_PREFIX}/share/foxitreader/images/FoxitReader-64x64.ico", "#{icon_path}/FoxitReader.ico"
  end

  def self.postinstall
    puts "\nType 'foxit' to get started.\n".lightblue
  end
end
