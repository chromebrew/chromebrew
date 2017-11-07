require 'package'

class Od1n < Package
  description '0d1n is a tool for automating customized attacks against web applications.'
  homepage 'https://github.com/CoolerVoid/0d1n'
  version '2.3'
  source_url 'https://github.com/CoolerVoid/0d1n/archive/2.3.tar.gz'
  source_sha256 '7fe26f0268fe63ec0352502ae590a7a5e258248f253649661dc782ca7edd52ae'

  depends_on 'curl'

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p ["#{CREW_DEST_PREFIX}/share/0d1n/payloads",
		       "#{CREW_DEST_PREFIX}/share/0d1n/templates",
		       "#{CREW_DEST_PREFIX}/share/0d1n/response2find",
		       "#{CREW_DEST_PREFIX}/share/0d1n/tables",
                       "#{CREW_DEST_PREFIX}/share/0d1n/doc"]
    FileUtils.cp_r ['doc','payloads','response2find','tables'], "#{CREW_DEST_PREFIX}/share/0d1n/"
    system "install -Dm755 0d1n #{CREW_DEST_PREFIX}/bin/0d1n"
    system "install -m644 *.conf #{CREW_DEST_PREFIX}/share/0d1n"
  end
end
