require 'package'

class Libssp < Package
  description '**FIXME**'
  homepage 'https://gcc.gnu.org/'
  version '10.3.0'
  license 'GPL-3, LGPL-3, libgcc, FDL-1.2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/gcc/gcc-10.3.0/gcc-10.3.0.tar.xz'
  source_sha256 '64f404c1a650f27fc33da242e1f2df54952e3963a49e06e73f6940f3223ac344'
  
  # local depends
#  depends_on '' #TBD (hopefully nothing, as ruby needs it)
  
  @gcc_name = 'libssp'
  @gcc_global_opts = '--enable-static \
                      --enable-shared \
                      --disable-multilib \
                      --disable-cet \
                      --with-pic \
                      --enable-symvers \
                      --with-gcc-major-version-only \
                      --with-system-libunwind'
  @gcc_global_env = "#{CREW_ENV_OPTIONS}"

  def self.build
    Dir.mkdir "#{@gcc_name}-builddir"
    Dir.chdir "#{@gcc_name}-builddir" do
      system "#{@gcc_global_env} ../#{@gcc_name}/configure #{CREW_OPTIONS} \
              #{@gcc_global_opts}"
      system "make"
    end
  end

  def self.check
    Dir.chdir "#{@gcc_name}-builddir" do
      system "make check"
    end
  end

  def self.install
    Dir.chdir "#{@gcc_name}-builddir" do
      system "make DESTDIR=#{CREW_DEST_DIR} install"
    end
  end
end
