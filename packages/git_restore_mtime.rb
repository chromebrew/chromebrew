# Adapted from Arch Linux git-tools-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=git-tools-git

require 'package'

class Git_restore_mtime < Package
  description 'Assorted git tools, including git-restore-mtime'
  homepage 'https://github.com/MestreLion/git-tools'
  version '2022.12'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/MestreLion/git-tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58e115db241d5b14dcd0e667d23249d077a0f9d507dacfcdbf9d10b0b8714804',
     armv7l: '58e115db241d5b14dcd0e667d23249d077a0f9d507dacfcdbf9d10b0b8714804',
       i686: 'cd632b25c4cbcc5799a13d07e47b662d804a7cb9dcd62479025991476cab044d',
     x86_64: '1a590202433b722a18ed599334356bd25fdfeaf2578dad600221166f3129ea75'
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
