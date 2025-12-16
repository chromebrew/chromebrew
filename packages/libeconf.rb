require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '320302349b85bc59560cf4b1cc56b1e3b06ed01b0cf41a8c54d0a69a728cc653',
     armv7l: '320302349b85bc59560cf4b1cc56b1e3b06ed01b0cf41a8c54d0a69a728cc653',
       i686: 'ff6cb48702a86210c30b2b4cb3e8a5eda620402018cd27ce588f659d6a15359f',
     x86_64: '55c77c064583fc6f002052e968e26dae26875a0a8e41961b50a5ec8a98b9894c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
