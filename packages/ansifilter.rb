require 'buildsystems/cmake'

class Ansifilter < CMake
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.23'
  license 'GPL-3+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.com/saalen/ansifilter.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0da205b3aec5dc6c8df09607248dfea49d1a52dd0eea6d142d1a4464a8586e9',
     armv7l: 'b0da205b3aec5dc6c8df09607248dfea49d1a52dd0eea6d142d1a4464a8586e9',
     x86_64: 'ab5dbfcf568c4d668e9070b4d2acb47f7fbb562ae004276e7e338f8fac9e819f'
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
