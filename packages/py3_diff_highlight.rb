require 'buildsystems/pip'

class Py3_diff_highlight < Pip
  description 'pretty diff highlighter; emphasis changed words in diff'
  homepage 'https://github.com/tk0miya/diff-highlight'
  version "1.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5720c3a23dbf12d65e976468f6cb6c4d97504c7089c39768045f0282e2be00f2',
     armv7l: '5720c3a23dbf12d65e976468f6cb6c4d97504c7089c39768045f0282e2be00f2',
       i686: 'fb7866cdabdf2e316e2224d05fe102cf81050e8b1a37eec71c72c9b08e6f5c0d',
     x86_64: 'd4a75413da5e38bb48c6a7ecf4333ab8ee95aa10ea3b6a8fe66eaf123fa6bbca'
  })

  depends_on 'python3' => :logical

  no_source_build
end
