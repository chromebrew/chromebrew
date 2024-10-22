# Adapted from Arch Linux git-tools-git PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=git-tools-git

require 'package'

class Git_mestrelion_tools < Package
  description 'Assorted git tools, including git-restore-mtime'
  homepage 'https://github.com/MestreLion/git-tools'
  version '2022.12'
  license 'GPL3'
  compatibility 'all'
  source_url 'https://github.com/MestreLion/git-tools.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e008b4240a6ff1580dcb0786cc687454608d2a3dd3351da9bb7aa0a17a44cfa7',
     armv7l: 'e008b4240a6ff1580dcb0786cc687454608d2a3dd3351da9bb7aa0a17a44cfa7',
       i686: 'ccb3144001c111b47c4851e6b670090e8cfccee02d1a19624865dfdbdeafc47a',
     x86_64: '9cc57f97e060f2604f8a0e1710ac118869bc27f7487017d8dd58652398fe1346'
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
