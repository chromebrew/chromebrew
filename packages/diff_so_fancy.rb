require 'package'

class Diff_so_fancy < Package
  description 'diff-so-fancy strives to make your diffs human readable instead of machine readable.'
  homepage 'https://github.com/so-fancy/diff-so-fancy'
  version '1.4.10'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/so-fancy/diff-so-fancy.git'
  git_hashtag version

  depends_on 'perl' # R

  no_compile_needed

  def self.install
    FileUtils.install 'diff-so-fancy', "#{CREW_DEST_PREFIX}/bin/diff-so-fancy", mode: 0o755
  end
end
