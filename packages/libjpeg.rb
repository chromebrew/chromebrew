require 'package'

class Libjpeg < Package
  description 'JPEG is a free library for image compression.'
  homepage 'https://www.ijg.org/'
  version '9.5.0'
  license 'custom' # Very similar to the BSD license
  compatibility 'all'
  source_url 'https://www.ijg.org/files/jpegsrc.v9e.tar.gz'
  source_sha256 '4077d6a6a75aeb01884f708919d25934c93305e49f7e3f36db9129320e6f4f3d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.5.0_armv7l/libjpeg-9.5.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.5.0_armv7l/libjpeg-9.5.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.5.0_i686/libjpeg-9.5.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libjpeg/9.5.0_x86_64/libjpeg-9.5.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9d4d0f83f1e20b55f8644b36c5b7eef3eb2611072a7e450d7a177dfb64c9d5af',
     armv7l: '9d4d0f83f1e20b55f8644b36c5b7eef3eb2611072a7e450d7a177dfb64c9d5af',
       i686: 'fb10871ac819a3fae4f10feedcaa9cf52fa596c8332e6124540664da88ec78ec',
     x86_64: 'ab398f69178d245dd9a477f615d0e6b3bb19bc5bc31ab0dfd967055ccb261498'
  })

  def self.build
    system '[ -x configure ] || ./bootstrap.py'
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    Dir.chdir CREW_DEST_LIB_PREFIX do
      FileUtils.ln_s 'libjpeg.so.9.5.0', 'libjpeg.so.8'
    end
  end
end
