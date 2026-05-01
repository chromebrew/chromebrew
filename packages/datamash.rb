require 'buildsystems/autotools'

class Datamash < Autotools
  description 'GNU Datamash is a command-line program which performs basic numeric, textual and statistical operations on input textual data files.'
  homepage 'https://www.gnu.org/software/datamash/'
  version '1.9'
  license 'GPL-3'
  compatibility 'all'
  source_url "https://ftp.gnu.org/gnu/datamash/datamash-#{version}.tar.gz"
  source_sha256 'f382ebda03650dd679161f758f9c0a6cc9293213438d4a77a8eda325aacb87d2'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb73f1f049abf4858255eb006d3d1763200bfd4a6bbdc3acc5eb8c1bfe956dbd',
     armv7l: 'fb73f1f049abf4858255eb006d3d1763200bfd4a6bbdc3acc5eb8c1bfe956dbd',
       i686: 'c0b80773a9166876c853877d5859548d193f8d3c7131152319c69456aefb7164',
     x86_64: '5572020a7641d3d03ee7cbcc58b9dfba05a235a941e2b9efcd67c019c2230987'
  })

  depends_on 'glibc' => :executable

  def self.patch
    # The aclocal version is hardcoded.
    aclocal_version = `aclocal --version|head -1|cut -d' ' -f4`.chomp.gsub(/\.\d+$/, '')
    system "sed -i 's,1.17,#{aclocal_version},g' configure"
  end

  # Fix error: weak declaration of 'thrd_exit' must be public
  autotools_configure_options '--disable-threads'

  run_tests
end
