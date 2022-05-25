require 'package'

class Premake < Package
  description 'Premake is a command line utility which reads a scripted definition of a software project and, most commonly, uses it to generate project files for toolsets like Visual Studio, Xcode, or GNU Make.'
  homepage 'https://premake.github.io/'
  version '5.0.0-alpha15'
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'https://github.com/premake/premake-core/releases/download/v5.0.0-alpha15/premake-5.0.0-alpha15-src.zip'
  source_sha256 '880f56e7cb9f4945d1cb879f059189462c1b7bf62ef43ac7d25842dfb177dd53'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/premake/5.0.0-alpha15_armv7l/premake-5.0.0-alpha15-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/premake/5.0.0-alpha15_armv7l/premake-5.0.0-alpha15-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/premake/5.0.0-alpha15_i686/premake-5.0.0-alpha15-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/premake/5.0.0-alpha15_x86_64/premake-5.0.0-alpha15-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '131030ca43e230433f27821f0e786939f185f0c8717e9dc49026f4428609fb8d',
     armv7l: '131030ca43e230433f27821f0e786939f185f0c8717e9dc49026f4428609fb8d',
       i686: 'ead843bf76e3c4310d3b674f050e1d9f51b9ec6cba440185a7f087c78f220608',
     x86_64: '6bcc52ff54cb5b65738b3e7b6a89bd26edc88945a1d63623e0829a9b14d4d11c'
  })

  def self.build
    Dir.chdir 'build/gmake2.unix' do
      system 'make', 'all'
    end
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'bin/release/premake5', "#{CREW_DEST_PREFIX}/bin/premake", mode: 0o755
  end

  def self.postinstall
    puts "\nType 'premake --help' to get started.\n".lightblue
  end
end
