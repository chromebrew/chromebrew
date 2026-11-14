require 'buildsystems/meson'

class Libeconf < Meson
  description 'Enhanced config file parser, which merges config files placed in several locations into one.'
  homepage 'https://github.com/openSUSE/libeconf'
  version '0.8.7'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/openSUSE/libeconf.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0bc7143fcf813b2d13e46ffddf709a59e7abf1ab1cc3e6e00ecccc9606a7cd84',
     armv7l: '0bc7143fcf813b2d13e46ffddf709a59e7abf1ab1cc3e6e00ecccc9606a7cd84',
       i686: 'b2d47a57c5898907c250a952289e16177ddd0646abb0fc229628bc8a866c5c94',
     x86_64: 'bab4248cac87d3f002d2300a7f655de544bf43a08dab085ecf6a8ca4dcc5706f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
