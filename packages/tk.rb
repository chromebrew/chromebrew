require 'buildsystems/autotools'

class Tk < Autotools
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'https://tcl.tk'
  version '9.0.2'
  license 'tcltk'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tk#{version}-src.tar.gz"
  source_sha256 'd6f01a4d598bfc6398be9584e1bab828c907b0758db4bbb351a1429106aec527'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9eb8d8c1044475496fee0086d4882e8f13d6a7d52efead0933dff557d824ff0a',
     armv7l: '9eb8d8c1044475496fee0086d4882e8f13d6a7d52efead0933dff557d824ff0a',
     x86_64: '9bec423514244a77790075b6c49fcc598406e138a67053f66ce66b9cb40d005d'
  })

  depends_on 'fontconfig' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxft' # R
  depends_on 'libxss' # R
  depends_on 'tcl' # R
  depends_on 'zlib' # R

  no_lto

  autotools_build_relative_dir 'unix'
  autotools_configure_options "--with-tcl=#{CREW_LIB_PREFIX} \
          --enable-threads \
          --#{ARCH == 'x86_64' ? 'enable' : 'disable'}-64bit"

  autotools_install_extras do
    FileUtils.ln_s "#{CREW_PREFIX}/bin/wish#{version.rpartition('.')[0]}", "#{CREW_DEST_PREFIX}/bin/wish"
  end
end
