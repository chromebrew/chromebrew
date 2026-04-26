require 'buildsystems/autotools'

class Audiofile < Autotools
  description 'Audio File Library'
  homepage 'https://audiofile.68k.org/'
  version '0.3.6'
  license 'GPL-2.0, LGPL-2.1'
  compatibility 'all'
  source_url "https://download.gnome.org/sources/audiofile/#{version.sub(/\.\d+$/, '')}/audiofile-#{version}.tar.xz"
  source_sha256 'ea2449ad3f201ec590d811db9da6d02ffc5e87a677d06b92ab15363d8cb59782'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'daba37641c9265fd4279bad6704cb27b5e96ac740ace53f54c3077a9973ddc0d',
     armv7l: 'daba37641c9265fd4279bad6704cb27b5e96ac740ace53f54c3077a9973ddc0d',
       i686: '914aec147baafde22e2c2ed541730bd82df374d19efd9941b795bfdc21cae1b4',
     x86_64: '3d7c7184cd915888f107d713ff45100ad3b788af35250806826c868900446272'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'flac' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'py3_asciidoc' => :build
  depends_on 'valgrind' => :build

  def self.patch
    patch = [
      [
        # See https://linuxfromscratch.org/blfs/view/svn/multimedia/audiofile.html.
        "https://www.linuxfromscratch.org/patches/blfs/svn/audiofile-#{version}-consolidated_patches-1.patch",
        '7b6cb28a3853e6668c9c08b4fca3a93ab06c9c8aecc918903a7ce5bd46181ecf'
      ]
    ]
    ConvenienceFunctions.patch(patch)
  end

  def self.prebuild
    ConvenienceFunctions.libtoolize('libogg')
  end

  run_tests
end
