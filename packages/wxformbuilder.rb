require 'package'

class Wxformbuilder < Package
  description 'RAD tool for wxWidgets GUI design'
  homepage 'https://github.com/wxFormBuilder/wxFormBuilder'
  version '3.9.0'
  source_url 'https://github.com/wxFormBuilder/wxFormBuilder/archive/v3.9.0.tar.gz'
  source_sha256 'e63532e71828d5e168388380fe627225f997267495da4bf6c55ef592738bdc88'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
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
