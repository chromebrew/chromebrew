require 'buildsystems/cmake'

class Musecore < CMake
  description 'MuseScore is an open source and free music notation software.'
  homepage 'https://musescore.org'
  version '4.3.2' # Version 4.4.x requires QT6.
  license 'GPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/musescore/MuseScore.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4333f700d22de5970a002a7288d844237a1b8899ce179a99067c912fdb43ee4',
     armv7l: 'd4333f700d22de5970a002a7288d844237a1b8899ce179a99067c912fdb43ee4',
     x86_64: '8d239b903709a71b023a483433786c0f8c7201f101232a1a8e9e971fd8811f6f'
  })

  depends_on 'alsa_lib' # R
  depends_on 'flac'
  depends_on 'freetype'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libopusenc'
  depends_on 'libsndfile'
  depends_on 'openssl' # R
  depends_on 'opus' # R
  depends_on 'qt5_base'
  depends_on 'qt5_declarative'
  depends_on 'qt5_networkauth'
  depends_on 'qt5_quickcontrols2'
  depends_on 'qt5_svg'
  depends_on 'qt5_tools'
  depends_on 'qt5_x11extras'
  depends_on 'qt5_xmlpatterns'
  depends_on 'tinyxml2'
  depends_on 'zlib' # R

  # https://github.com/musescore/MuseScore/issues/15046
  no_lto
  # Tests fail unless run with QT_QPA_PLATFORM=offscreen set.
  # run_tests

  cmake_options '-DMUE_COMPILE_USE_SYSTEM_FLAC=ON \
    -DMUE_COMPILE_USE_SYSTEM_FREETYPE=ON \
    -DMUE_COMPILE_USE_SYSTEM_OPUSENC=ON \
    -DMUE_COMPILE_USE_SYSTEM_TINYXML=ON'
end
