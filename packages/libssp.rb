require 'package'

class Libssp < Package
  description 'Libssp is a part of the GCC toolkit.'
  homepage 'https://gcc.gnu.org/'
  version '10.3.0'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-10.3.0/gcc-10.3.0.tar.xz'
  source_sha256 '64f404c1a650f27fc33da242e1f2df54952e3963a49e06e73f6940f3223ac344'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libssp-10.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/libssp-10.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/libssp-10.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/libssp-10.3.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '96cccac5b98b142fdfeed83fcd2cc163dfcda386246366b4f7702ef9f1076649',
     armv7l: '96cccac5b98b142fdfeed83fcd2cc163dfcda386246366b4f7702ef9f1076649',
       i686: 'a4bf6df2e4e7d325b12c882702ae0a7262fdda7c1a109f7e044a4de7b206bbfc',
     x86_64: '6c59d395ebd6d461cdc619333566c2139f96209390f7826f58df264f42301c0e'
  })

  @gcc_name = 'libssp'
  @gcc_global_opts = '--enable-static \
                      --enable-shared \
                      --disable-multilib \
                      --disable-cet \
                      --with-pic \
                      --enable-symvers \
                      --with-gcc-major-version-only \
                      --with-system-libunwind'

  def self.build
    Dir.mkdir "#{@gcc_name}-builddir"
    Dir.chdir "#{@gcc_name}-builddir" do
      system "#{CREW_ENV_OPTIONS} ../#{@gcc_name}/configure #{CREW_OPTIONS} \
              #{@gcc_global_opts}"
      system 'make'
    end
  end

  def self.check
    Dir.chdir "#{@gcc_name}-builddir" do
      system 'make check'
    end
  end

  def self.install
    Dir.chdir "#{@gcc_name}-builddir" do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
