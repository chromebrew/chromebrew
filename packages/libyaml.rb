require 'buildsystems/autotools'

class Libyaml < Autotools
  description 'LibYAML is a YAML parser and emitter library.'
  homepage 'https://pyyaml.org/wiki/LibYAML'
  version '0.2.5-1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/yaml/libyaml.git'
  git_hashtag version.split('-').first
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '800ceaffa38afd706eb94907175c8e45ab5dad9e6d7f6fcc29121c53021a4eb8',
     armv7l: '800ceaffa38afd706eb94907175c8e45ab5dad9e6d7f6fcc29121c53021a4eb8',
       i686: '88961217ea4c8c49606beb0b65995c49e4e622944c25b55dc2fe9e52442a7e89',
     x86_64: 'fa9c1391a969c53c9bc6d1a67b60002bb162b840b2e7f47511c02e6819c67717'
  })

  depends_on 'glibc' # R
end
