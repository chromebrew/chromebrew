require 'package'

class Diff_so_fancy < Package
  description 'diff-so-fancy strives to make your diffs human readable instead of machine readable.'
  homepage 'https://github.com/so-fancy/diff-so-fancy'
  version '1.4.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.4/diff-so-fancy'
  source_sha256 '14ded2376a20ce089952c64a2894afeb70ff0b77e5d7b661eb1c973820208e59'

  depends_on 'perl' # R

  no_compile_needed

  def self.install
    FileUtils.install 'diff-so-fancy', "#{CREW_DEST_PREFIX}/bin/diff-so-fancy", mode: 0o755
  end
end
