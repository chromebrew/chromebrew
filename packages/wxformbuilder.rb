require 'package'

class Wxformbuilder < Package
  description 'RAD tool for wxWidgets GUI design'
  homepage 'https://github.com/wxFormBuilder/wxFormBuilder'
  version '3.9.0'
  compatibility 'all'
  source_url 'https://github.com/wxFormBuilder/wxFormBuilder/archive/v3.9.0.tar.gz'
  source_sha256 'e63532e71828d5e168388380fe627225f997267495da4bf6c55ef592738bdc88'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wxformbuilder-3.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wxformbuilder-3.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wxformbuilder-3.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wxformbuilder-3.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72919b2bd017609c541cdd137375e4f5b77ebbc575b64bf4c36f800ff9063acb',
     armv7l: '72919b2bd017609c541cdd137375e4f5b77ebbc575b64bf4c36f800ff9063acb',
       i686: '401bfac8ccbad94011998a2e8f1b30605fbae2c11e11469516b171d0fe96e334',
     x86_64: 'f812d32fda14a1a379be8d8c98c291da84f0353bd7cefc6f07bad3f8ad89b4ad',
  })

  depends_on 'wxwidgets'
  depends_on 'sommelier'

  def self.build
    system 'git clone --recursive --depth=1 https://github.com/wxFormBuilder/wxFormBuilder'
    Dir.chdir 'wxFormBuilder' do
      system "meson _build --prefix #{CREW_PREFIX} --libdir #{CREW_LIB_PREFIX}"
    end
  end

  def self.install
    Dir.chdir 'wxFormBuilder' do
      system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
      if ARCH == 'x86_64'
        FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib"
        FileUtils.ln_s "#{CREW_LIB_PREFIX}/wxformbuilder", "#{CREW_DEST_PREFIX}/lib/wxformbuilder"
      end
    end
  end
end
