require 'buildsystems/autotools'

class Tk < Autotools
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'https://tcl.tk'
  version '9.0.1'
  license 'tcltk'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tk#{version}-src.tar.gz"
  source_sha256 'd6f01a4d598bfc6398be9584e1bab828c907b0758db4bbb351a1429106aec527'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2785556c1d0cd4dc49f322f5e69e9217b5912c2b4bf0cd1cc84c308f7194cbfc',
     armv7l: '2785556c1d0cd4dc49f322f5e69e9217b5912c2b4bf0cd1cc84c308f7194cbfc',
     x86_64: '43e20a269bbe74ffaf4e8d7437635ecbb8d824f29d1e04c145774a53be5451e7'
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
