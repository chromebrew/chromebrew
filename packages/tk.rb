require 'buildsystems/autotools'

class Tk < Autotools
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'https://tcl.tk'
  version '9.0.4'
  license 'tcltk'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tk#{version}-src.tar.gz"
  source_sha256 'd7a146d2917eb8b5cc95276dbf0e3d03c7464d2b19c1675357857c989301dbb4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b6fae3bb22580af17c7b81cde2d009325ceae920c33f46a372c37498968d224',
     armv7l: '3b6fae3bb22580af17c7b81cde2d009325ceae920c33f46a372c37498968d224',
     x86_64: 'da87c608f95e7b88aba6ac74e421359595e65a73b24741abc460128d6dc387aa'
  })

  depends_on 'fontconfig' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libx11' => :library
  depends_on 'libxext' => :library
  depends_on 'libxft' => :library
  depends_on 'libxss' => :library
  depends_on 'tcl' => :executable
  depends_on 'zlib' => :library

  no_lto

  autotools_build_relative_dir 'unix'
  autotools_pre_configure_options "CFLAGS='-I#{CREW_PREFIX}/include/tcl9.0'"
  autotools_configure_options "--with-tcl=#{CREW_LIB_PREFIX} \
          --enable-threads \
          --#{ARCH == 'x86_64' ? 'enable' : 'disable'}-64bit"

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/wish#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/wish"
    if ARCH.eql?('x86_64')
      # FileUtils.mkdir_p  CREW_DEST_LIB_PREFIX
      FileUtils.mv Dir["#{CREW_DEST_PREFIX}/lib/tk9.0/*"], "#{CREW_DEST_LIB_PREFIX}/tk9.0"
    end
    Dir['../library/*.tcl'].each do |tclpath|
      tcl = File.basename(tclpath)
      FileUtils.install tclpath, "#{CREW_DEST_LIB_PREFIX}/#{tcl}", mode: 0o644
    end
    Dir['../library/ttk/*.tcl'].each do |tclpath|
      tcl = File.basename(tclpath)
      FileUtils.install tclpath, "#{CREW_DEST_LIB_PREFIX}/ttk/#{tcl}", mode: 0o644
    end
  end
end
