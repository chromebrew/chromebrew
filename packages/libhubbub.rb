require 'package'

class Libhubbub < Package
  description 'HTML5 compliant parsing library, written in C'
  homepage 'https://www.netsurf-browser.org'
  version '0.3.7'
  compatibility 'all'
  source_url 'https://download.netsurf-browser.org/libs/releases/libhubbub-0.3.7-src.tar.gz'
  source_sha256 '9e7ae253e6c9069e757eb9ad4e4846f38b4db52c0ca0151446a9fa4a977735b6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhubbub-0.3.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhubbub-0.3.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhubbub-0.3.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhubbub-0.3.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd6c275bf236ce2f15d6b50d46fe16d40ac1dad8fd580051af086721634700d60',
     armv7l: 'd6c275bf236ce2f15d6b50d46fe16d40ac1dad8fd580051af086721634700d60',
       i686: '58c82b54bbadb144ea47ec6dff7b5f0c7e7687e1bd2597ac00cf1bf0c2ed4c43',
     x86_64: 'b06aa6ea64790967274f69690ae87d8fb90468f244703353200be55394c56ad0',
  })

  depends_on 'libxslt'
  depends_on 'jsonc'
  depends_on 'libparserutils'

  def self.build
    system "make PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared"
  end

  def self.install
    system "make install PREFIX=#{CREW_PREFIX} COMPONENT_TYPE=lib-shared DESTDIR=#{CREW_DEST_DIR}"
    case ARCH
    when 'x86_64'
      Dir.chdir CREW_DEST_PREFIX do
        FileUtils.mv 'lib/', 'lib64/'
      end
    end
  end
end
