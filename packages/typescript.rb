# Adapted from Arch Linux typescript PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/typescript/trunk/PKGBUILD

require 'package'

class Typescript < Package
  description 'JavaScript with syntax for types'
  homepage 'http://www.typescriptlang.org'
  version '5.0.4'
  license 'Apache'
  compatibility 'all'
  source_url 'https://github.com/microsoft/typescript.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db9b20989f23947e00eec5f8bfd6181d5c41880227512e1033173b1ed6ced1af',
     armv7l: 'db9b20989f23947e00eec5f8bfd6181d5c41880227512e1033173b1ed6ced1af',
       i686: 'ceb26159248f454776599e094ebed584f3c6bb74963df861973937e3418f1078',
     x86_64: '9ad883af55bc37a4f65f4719333736b15d0cbe953683a3a07806420e431affdf'
  })

  depends_on 'nodebrew' # L
  depends_on 'rsync' => :build

  no_upstream_update # newer versions do not build with older node.

  def self.prebuild
    system 'crew postinstall nodebrew' unless File.exist?("#{CREW_PREFIX}/bin/node")
  end

  def self.build
    system 'npm ci'
    system 'npx hereby LKG'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}/node_modules"
    %w[tsc tsserver].each do |bin|
      FileUtils.ln_s "../#{ARCH_LIB}/node_modules/typescript/bin/#{bin}", "#{CREW_DEST_PREFIX}/bin/"
    end
    system "rsync -r --exclude .gitattributes README.md SECURITY.md bin lib package.json #{CREW_DEST_LIB_PREFIX}/node_modules/typescript"
  end
end
