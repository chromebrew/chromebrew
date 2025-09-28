# Adapted from Arch Linux git-tools-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=git-tools-git

require 'package'

class Git_mestrelion_tools < Package
  description 'Assorted git tools, including git-restore-mtime'
  homepage 'https://github.com/MestreLion/git-tools'
  version '2025.08'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/MestreLion/git-tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae4937d3bd9e95f0ec52a7fa0f405a1d6ac1ed33546910502e785fa6cc3f231d',
     armv7l: 'ae4937d3bd9e95f0ec52a7fa0f405a1d6ac1ed33546910502e785fa6cc3f231d',
       i686: 'ee2c1d18e6076e755493b81c85ad8818e4a599db9ccef4ec6d92c6bddcfa6f92',
     x86_64: '28b264b6db79bb775854ab9614070bd2e5af02fb2e557b01f4dd6e6dfa1e7018'
  })

  depends_on 'git' # L
  depends_on 'python3' # R

  def self.install
    Dir.glob('man1/*.1') do |man|
      FileUtils.install man, "#{CREW_DEST_MAN_PREFIX}/#{man}", mode: 0o644
    end
    Dir.glob('git-*') do |app|
      FileUtils.install app, "#{CREW_DEST_PREFIX}/bin/#{app}", mode: 0o755
    end
  end
end
