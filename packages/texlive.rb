require 'package'

class Texlive < Package
  description 'TeX Live is an easy way to get up and running with the TeX document production system.'
  homepage 'https://www.tug.org/texlive/'
  version '20200406'
  license 'GPL-2 and GPL-3'
  compatibility 'all'
  source_url 'https://github.com/TeX-Live/texlive-source/archive/refs/tags/svn58528.tar.gz'
  source_sha256 '5c2e53d25d2f85d511bb3fa238e2de718ce27e22db83559284570b5c380f4bed'

  depends_on 'perl'
  depends_on 'freetype'
  depends_on 'harfbuzz'
  depends_on 'libpng'
  depends_on 'cairo'
  depends_on 'libpaper'
  depends_on 'graphite'
  depends_on 'libxmu'
  depends_on 'libxaw'
  depends_on 'icu4c'
  depends_on 'pixman'
  depends_on 'zlibpkg'
  depends_on 'poppler'
  #depends_on 'lua'
  #depends_on 'luajit'
  depends_on 'zziplib'
  depends_on 'texinfo' => :build

  def self.prebuild
    # This is for people building with limited filespace
    Dir.chdir 'libs' do
      FileUtils.rm_rf 'cairo'
      FileUtils.rm_rf 'freetype2'
      FileUtils.rm_rf 'gd'
      FileUtils.rm_rf 'gmp'
      FileUtils.rm_rf 'graphite2'
      FileUtils.rm_rf 'harfbuzz'
      FileUtils.rm_rf 'libpaper'
      FileUtils.rm_rf 'libpng'
      #FileUtils.rm_rf 'lua53'
      #FileUtils.rm_rf 'luajit'
      FileUtils.rm_rf 'mfpr'
      FileUtils.rm_rf 'pixman'
      FileUtils.rm_rf 'poppler'
      FileUtils.rm_rf 'zlib'
      FileUtils.rm_rf 'zziplib'
    end
  end

  def self.build
    system "filefix"
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "env CFLAGS='-pipe -flto=auto -fuse-ld=gold \
                  CXXFLAGS='-pipe -flto=auto -fuse-ld=gold \
                  LDFLAGS='-flto=auto' \
              ../configure #{CREW_OPTIONS} \
		            --enable-biber \
		            --enable-epsfwin \
		            --enable-ipc \
		            --enable-luatex \
		            --enable-mftalkwin \
		            --enable-regiswin \
		            --enable-shared \
		            --enable-tektronixwin \
		            --enable-unitermwin \
		            --enable-xetex \
		            --enable-dvipng \
		            --enable-dvipsk \
		            --enable-ps2eps \
		            --enable-psutils \
	              --disable-bibtex-x \
  		          --disable-chktex \
	  	          --disable-cjkutils \
		            --disable-detex \
		            --disable-dialog \
		            --disable-dvi2tty \
	              --disable-dvisvgm \
		            --disable-largefile \
		            --disable-lcdf-typetools \
  		          --disable-multiplatform \
	  	          --disable-native-texlive-build \
		            --disable-pdfopen \
		            --disable-ps2pkm \
		            --disable-t1utils \
		            --disable-tex4htk \
		            --disable-ttf2pk2 \
                --disable-vlna \
                --disable-xindy \
                --with-ps=gs \
                --with-system-cairo \
                --with-system-freetype2 \
                --with-system-gd \
                --with-system-gmp \
                --with-system-graphite2 \
                --with-system-harfbuzz \
                --with-system-icu \
                --with-system-libpaper \
                --with-system-libpng \
                --with-system-mpfr \
                --with-system-pixman \
                --with-system-poppler \
                --with-system-zlib \
                --with-system-zziplib \
                --with-texinfo \
                --with-x \
                --with-ln-s \
                --with-x-dvi-toolkit=motif \
                --with-banner-add='Chromebrew' "

                # Options to add with later packages
                # --with-system-kpathsea \
                # --with-system-ptexenc \
                # --with-system-teckit \
                # --with-system-xpdf \

                # Texlive doesn't support these options (yet)
                #--with-system-lua53 \
                #--with-system-luajit \
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'builddir' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
    path = `echo #{CREW_PREFIX}/share/texlive/20*`.chomp
    @env = <<~EOF
      # texlive configuration
      export PATH="$PATH:#{path}/bin/#{ARCH}-linux"
      export MANPATH="$MANPATH:#{path}/bin/texmf-dist/doc/man"
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/env.d/FIXME", @env)
  end

  def self.postinstall
    puts
    puts "\nThis is a very small installation, with only the basic packages. To install more, use `tlmgr install <package>`.".lightblue
    puts
  end
end
