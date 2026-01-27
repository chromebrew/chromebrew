require 'buildsystems/autotools'

class Tk < Autotools
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'https://tcl.tk'
  version '9.0.3'
  license 'tcltk'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{version}/tk#{version}-src.tar.gz"
  source_sha256 'bf344efadb618babb7933f69275620f72454d1c8220130da93e3f7feb0efbf9b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27aef4e43f3eafbea4e1fd444e82988187510084fd905aad1bafe7ad503a90e7',
     armv7l: '27aef4e43f3eafbea4e1fd444e82988187510084fd905aad1bafe7ad503a90e7',
     x86_64: 'ffb7c63db274057893327ab315a1bf1af6f8d74d3198b230a3e530b8c3ea0eb9'
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
