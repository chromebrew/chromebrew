require 'package'

class Aview < Package
  description 'aview is an high quality ascii-art image(pnm) browser and animation(fli/flc) player usefull especially with lynx browser.'
  homepage 'http://aa-project.sourceforge.net/aview/'
  version '1.3.0rc1'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aview/1.3.0rc1/aview-1.3.0rc1.tar.gz'
  source_sha256 '42d61c4194e8b9b69a881fdde698c83cb27d7eda59e08b300e73aaa34474ec99'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'aalib'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-x'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
