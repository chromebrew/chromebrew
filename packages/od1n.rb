require 'package'

class Od1n < Package
  description '0d1n is a tool for automating customized attacks against web applications.'
  homepage 'https://github.com/CoolerVoid/0d1n'
  version '2.5'
  source_url 'https://github.com/CoolerVoid/0d1n/archive/0d1n2.5.tar.gz'
  source_sha256 'c883907e44e7fc087af170ff82f063febde941dce9b46646b4ecc8410b887b3d'

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
