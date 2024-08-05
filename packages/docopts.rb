require 'package'

class Docopts < Package
  description 'Shell interpreter for docopt, the command-line interface description language.'
  homepage 'https://github.com/docopt/docopts'
  version '0.6.4-62aed3d'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/docopt/docopts.git'
  git_hashtag '62aed3d4cb02f36864ace03ecb89f8a200e311ca'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e28c9b494b9849837e3517e64adf00b61311032470571e38c471086f47740d8e',
     armv7l: 'e28c9b494b9849837e3517e64adf00b61311032470571e38c471086f47740d8e',
       i686: 'b1c2b5d84fd5d8888141f15ed6d514e56940d6eb3b364257b1bb10a754f108c0',
     x86_64: 'f2caa8352dd4c1bd96487365d53d1d5b00a1cb18b8e6a2275e5375de98bc9abe'
  })

  # Test dependencies are commented out, as tests are currently disabled.
  # depends_on 'bats' => :build
  depends_on 'go' => :build
  # depends_on 'python3' => :build
  # depends_on 'wget2' => :build

  def self.patch
    # build: replace deploy.sh with goreleaser
    Downloader.download 'https://patch-diff.githubusercontent.com/raw/docopt/docopts/pull/65.patch', 'b464038dd631d4d25c5541303f525c3d7d59d95236f6e6e55589ec459c3219ab'
    system 'git apply 65.patch'
  end

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    system 'make', "PREFIX=#{CREW_DEST_PREFIX}", 'install'
  end

  # Tests currently fail:
  # https://github.com/docopt/docopts/issues/75
  # def self.check
  #   system 'make test'
  # end
end
