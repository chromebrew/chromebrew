require 'buildsystems/autotools'

class Magic < Autotools
  description 'Magic is a venerable VLSI layout tool'
  homepage 'http://opencircuitdesign.com/magic/'
  version '8.3.517'
  license 'HPND-UC-export-US'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/RTimothyEdwards/magic.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6dd41c31cc3855ffd216f1fda31700dca201a536ec8788c52a851adfb7cb0655',
     armv7l: '6dd41c31cc3855ffd216f1fda31700dca201a536ec8788c52a851adfb7cb0655',
     x86_64: 'fdf7c8b642b10643fda9fe0f01f003fde0acfde5d9732acca905bbb896547e4f'
  })

  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'tcl' # R
  depends_on 'tk' # R
  depends_on 'zlib' # R

  autotools_configure_options "--with-tcl=#{CREW_LIB_PREFIX} --with-tk=#{CREW_LIB_PREFIX}"
end
