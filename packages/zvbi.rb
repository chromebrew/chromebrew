require 'package'

class Zvbi < Package
  description 'The Zapping VBI library, in short ZVBI, provides functions to capture and decode VBI data.'
  homepage 'http://zapping.sourceforge.net/ZVBI/'
  version '0.2.35-2'
  license 'GPL-2 and LGPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/zapping/zvbi/0.2.35/zvbi-0.2.35.tar.bz2'
  source_sha256 'fc883c34111a487c4a783f91b1b2bb5610d8d8e58dcba80c7ab31e67e4765318'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8540c8bf13aa2b9e8df2e1652d11d54c3eee1cc94aa8f282d9f1fa9d72fbf61f',
     armv7l: '8540c8bf13aa2b9e8df2e1652d11d54c3eee1cc94aa8f282d9f1fa9d72fbf61f',
       i686: 'bc08d5d03f44f8db298e76fa5dd25328d06e6d88914ea1944092d4dfdc1eb2c2',
     x86_64: '1646789cf7bae04f328d2000d5a40829798f9aa6a0955cd2b7ce41aa84a56a1d'
  })

  depends_on 'harfbuzz'

  def self.patch
    system 'filefix'
    # png.h path isn't found for build properly
    @png_h_path = `crew whatprovides png.h | grep "png.h$" | awk '{print $2}'`.chomp.gsub("#{CREW_PREFIX}/include/", '')
    system "sed -i 's,png.h,#{@png_h_path},g' src/exp-gfx.c"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
