require 'buildsystems/cmake'

class Ansifilter < CMake
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.24'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/saalen/ansifilter.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c6a1e4d7b7c9dedbd05c7c2ea59c7ba8570ea1ae755002c035632b36c2e56bd',
     armv7l: '0c6a1e4d7b7c9dedbd05c7c2ea59c7ba8570ea1ae755002c035632b36c2e56bd',
     x86_64: '7e60fd6b5ec579bec8c78f810da5b20d87430dbc30030ead462d925a139acc84'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'qt5_base' => :executable

  # For some reason, we are not able to set PREFIX.
  def self.patch
    system "sed -i 's,set(PREFIX /usr),set(PREFIX #{CREW_PREFIX}),' CMakeLists.txt"
  end
end
