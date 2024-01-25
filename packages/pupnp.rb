require 'package'

class Pupnp < Package
  description 'PUPnP is the Portable SDK for UPnP devices.'
  homepage 'https://pupnp.github.io/pupnp/'
  version '1.14.12'
  compatibility 'all'
  license 'BSD-3'
  source_url 'https://github.com/pupnp/pupnp.git'
  git_hashtag "release-#{version}"
  binary_compression 'tpxz'

  binary_sha256({
    aarch64: 'dfd091b7ed9f05b4f430b5f222ec455d682e892b2c1cb8335a7128c6e31c9c64',
      armv7l: 'dfd091b7ed9f05b4f430b5f222ec455d682e892b2c1cb8335a7128c6e31c9c64',
        i686: '65e7f095ae985ff94ea5a95747e591f29f81be37cc6c783a86416d909f2e859e',
      x86_64: '018d7c94f418c608deb388654334e43f61cd2c07c1d8e19b4743ff905308926a'
  })

  def self.build
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G 'Ninja' #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end

  def self.check
    system 'samu -C builddir test'
  end
end
