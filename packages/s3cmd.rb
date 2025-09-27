require 'buildsystems/python'

class S3cmd < Python
  description 'Command line tool for managing Amazon S3 and CloudFront services'
  homepage 'https://s3tools.org/s3cmd'
  version '2.4.0'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/s3tools/s3cmd.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b7c158c7d97f96b16858c904527c0f07e6afef1f4104e5bb3295a6c90126d9ee',
     armv7l: 'b7c158c7d97f96b16858c904527c0f07e6afef1f4104e5bb3295a6c90126d9ee',
       i686: '6894b03a2709dd9c56b432c3ff700358bbad390ff99b2a6329b60e48920b439d',
     x86_64: '49ca1d6525e4342b419a3b5ac804d812d28b35a6be1176057fcfae9dea2ea98f'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'py3_python_magic'
  depends_on 'python3' => :build
end
