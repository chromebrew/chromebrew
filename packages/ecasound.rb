require 'buildsystems/autotools'

class Ecasound < Autotools
  description 'Ecasound is a software package designed for multitrack audio processing.'
  homepage 'https://ecasound.seul.org/ecasound/'
  version '2.9.3'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://git.code.sf.net/p/ecasound/code' # The github repository does not have the tags.
  git_hashtag "v#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0673a7d622b71db4c881d570691218f739b1b6092ab01617d3ab070de2633b7',
     armv7l: 'b0673a7d622b71db4c881d570691218f739b1b6092ab01617d3ab070de2633b7',
       i686: 'be223ffc0ba90c8e8b37890ac26cc546d6a56a6794abc1148836a9118b1a417f',
     x86_64: 'e51ceabd4f781a0f172ab2a446dd7349f71a2fe8ee396f23a3f583ba0da8d28e'
  })

  def self.patch
    # Allow building as shared library
    downloader 'https://patch-diff.githubusercontent.com/raw/kaivehmanen/ecasound/pull/4.patch', 'a5caeb1dfe580f1e338dddd849ed18f7ce3a32f83c5ea63297e4cbaeadc3088b'
    system 'git apply 4.patch'

    # build: Use PKG_CHECK_MODULES to find readline
    downloader 'https://patch-diff.githubusercontent.com/raw/kaivehmanen/ecasound/pull/6.patch', '11aa2f31665172c3ab98e136f021e55e6c2e7b11e0fc5e05e9ea449e3d32af8b'
    system 'git apply 6.patch'
  end

  depends_on 'alsa_lib'
  depends_on 'flac'
  depends_on 'libogg' # R
  depends_on 'libsndfile'
  depends_on 'libvorbis' # R
  depends_on 'ncurses' # R
  depends_on 'opus' # R
  depends_on 'readline'
  depends_on 'ruby'

  autotools_configure_options '--disable-pyecasound'
  run_tests
end
