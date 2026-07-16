require 'package'

class Diff_so_fancy < Package
  description 'diff-so-fancy strives to make your diffs human readable instead of machine readable.'
  homepage 'https://github.com/so-fancy/diff-so-fancy'
  version '1.4.12'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/so-fancy/diff-so-fancy.git'
  git_hashtag "v#{version}"

  depends_on 'perl' => :logical

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'diff-so-fancy', "#{CREW_DEST_PREFIX}/share/diff-so-fancy/diff-so-fancy", mode: 0o755
    FileUtils.ln_s "#{CREW_PREFIX}/share/diff-so-fancy/diff-so-fancy", "#{CREW_DEST_PREFIX}/bin/diff-so-fancy"
    FileUtils.ln_s "#{CREW_PREFIX}/share/diff-so-fancy/diff-so-fancy", "#{CREW_DEST_PREFIX}/bin/d-s-f"
    FileUtils.ln_s "#{CREW_PREFIX}/share/diff-so-fancy/diff-so-fancy", "#{CREW_DEST_PREFIX}/bin/dsf"
    FileUtils.mv 'lib', "#{CREW_DEST_PREFIX}/share/diff-so-fancy"
  end
end
