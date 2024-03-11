require 'package'

class Aview < Package
  description 'aview is an high quality ascii-art image(pnm) browser and animation(fli/flc) player useful especially with lynx browser.'
  homepage 'http://aa-project.sourceforge.net/aview/'
  version '1.3.0rc1'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aview/1.3.0rc1/aview-1.3.0rc1.tar.gz'
  source_sha256 '42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'b7dac7b7bb1df20b2f3c5f4b3072d7c687d00187a7f65e25e7d754b658215bcd',
     armv7l: 'b7dac7b7bb1df20b2f3c5f4b3072d7c687d00187a7f65e25e7d754b658215bcd',
     x86_64: '70d29a20c0ade541d6f0aba440412d844a4815f8c0317a00d7c13005e1232395'
  })

  depends_on 'aalib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-x'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
